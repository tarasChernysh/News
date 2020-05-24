//
//  NewsPaginationService.swift
//  News
//
//  Created by Taras Chernysh on 10/13/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift

final class NewsPaginationService: NSObject, UseCasesConsumer {
    typealias UseCases = NetworkUseCase
    
    enum State {
        case general
        case category(CategoryVC.Item)
        case country(AllowedCountry)
        case searchNews(SearchQuestion)
    }
    
    // MARK: - Properties
    
    let state: State
    private let (lifetime, token) = Lifetime.make()
    private var news: [News] = []
    private var currentPage = 1
    private let resultsNumber = 8
    let isFetchInProgress = MutableProperty(false)
    let fetchedError = MutableProperty<AppError>(AppError.defaultError)
    let endNews = MutableProperty<AlertViewModel?>(nil)
    let successFetch = MutableProperty(false)
    var currentCount: Int {
        return news.count
    }
    
    func removeAll() {
        news.removeAll()
    }
    
    func news(at index: Int) -> News {
        return news[index]
    }
    
    //MARK: Initialization  
    
    init(state: State) {
        self.state = state
        super.init()
        useCases = NetworkService()
    }
    
    //MARK: Helper Method
    
    func fetchNews() {
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        if UserDefaults.standard.availableCountNews > UserDefaults.standard.newsTotalResult || UserDefaults.standard.availableCountNews == 0 {
            useCases.fetchNewsListWith(LimitOffset(page: currentPage, limit: resultsNumber)).take(during: lifetime).startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someNews):
                    self.isFetchInProgress.value = false
                    someNews.forEach { item in
                        self.news.append(item)
                    }
                    self.successFetch.value = true
                    UserDefaults.standard.newsTotalResult += someNews.count
                    self.currentPage += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
            }
            return
        }
        isFetchInProgress.value = false
        let alertViewModel = AlertViewModel(title: " ", message: "Sorry, but news is end")
        endNews.value = alertViewModel
    }
    
    func fetchCountryNews() {
        guard case .country(let country) = state else { return }
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        if UserDefaults.standard.availableCountCategoryNews > UserDefaults.standard.categoryNewsTotalResult || UserDefaults.standard.availableCountCategoryNews == 0 {
            let pagination = LimitOffset(page: currentPage, limit: resultsNumber)
            useCases.fetchCountryListNews(pagination, country: country).take(during: lifetime).startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someNews):
                    self.isFetchInProgress.value = false
                    someNews.forEach { item in
                        self.news.append(item)
                    }
                    self.successFetch.value = true
                    UserDefaults.standard.categoryNewsTotalResult += someNews.count
                    self.currentPage += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
            }
            return
        }
        isFetchInProgress.value = false
        let alertViewModel = AlertViewModel(title: " ", message: "Sorry, but news is end")
        endNews.value = alertViewModel
    }
    
    func fetchCategoryNews() {
        guard case .category(let category) = state else { return }
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        if UserDefaults.standard.availableCountCategoryNews > UserDefaults.standard.categoryNewsTotalResult || UserDefaults.standard.availableCountCategoryNews == 0 {
            let pagination = LimitOffset(page: currentPage, limit: resultsNumber)
            
            useCases.fetchCategoryListNews(pagination, category: category).take(during: lifetime).startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someNews):
                    self.isFetchInProgress.value = false
                    someNews.forEach { item in
                        self.news.append(item)
                    }
                    self.successFetch.value = true
                    UserDefaults.standard.categoryNewsTotalResult += someNews.count
                    self.currentPage += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
            }
            return
        }
        isFetchInProgress.value = false
        let alertViewModel = AlertViewModel(title: " ", message: "Sorry, but news is end")
        endNews.value = alertViewModel
    }
    
    func searchNews() {
        guard case .searchNews(let question) = state else { return }
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        if UserDefaults.standard.availableCountCategoryNews > UserDefaults.standard.categoryNewsTotalResult || UserDefaults.standard.availableCountCategoryNews == 0 {
            let pagination = LimitOffset(page: currentPage, limit: resultsNumber)
            
            useCases.searchListNews(pagination, question: question).take(during: lifetime).startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someNews):
                    self.isFetchInProgress.value = false
                    someNews.forEach { item in
                        self.news.append(item)
                    }
                    self.successFetch.value = true
                    UserDefaults.standard.categoryNewsTotalResult += someNews.count
                    self.currentPage += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
            }
            return
        }
        isFetchInProgress.value = false
        let alertViewModel = AlertViewModel(title: " ", message: "Sorry, but news is end")
        endNews.value = alertViewModel
    }
}
