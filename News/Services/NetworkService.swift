//
//  NetworkService.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya

protocol NetworkUseCase {
    func fetchCategoryListNews(_ pagination: LimitOffset, category: CategoryVC.Item) -> SignalProducer<[News], AppError>
    func fetchCountryListNews(_ pagination: LimitOffset, country: AllowedCountry) -> SignalProducer<[News], AppError>
    func fetchNewsListWith(_ pagination: LimitOffset) -> SignalProducer<[News], AppError>
    func fetchSources() -> SignalProducer<[SourceNews], AppError>
    func searchListNews(_ pagination: LimitOffset, question: SearchQuestion) -> SignalProducer<[News], AppError>
}

class NetworkService: NetworkUseCase {
    
    private let provider = MoyaProvider<NewsAPI>(plugins:[NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    func fetchCategoryListNews(_ pagination: LimitOffset, category: CategoryVC.Item) -> SignalProducer<[News], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.listForCategory(pagination, category), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseNews = try decoder.decode(Article.Response.self, from: response.data)
                        let news = responseNews.articles.map { News($0) }
                        UserDefaults.standard.availableCountCategoryNews = responseNews.totalResults
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                    
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                    
                }
            })
            
        }).observe(on: UIScheduler())
    }
    
    func fetchCountryListNews(_ pagination: LimitOffset, country: AllowedCountry) -> SignalProducer<[News], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.listForCountry(pagination, country), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseNews = try decoder.decode(Article.Response.self, from: response.data)
                        let news = responseNews.articles.map { News($0) }
                        UserDefaults.standard.availableCountCategoryNews = responseNews.totalResults
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                    
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                    
                }
            })
            
        }).observe(on: UIScheduler())
    }
    
    func fetchNewsListWith(_ pagination: LimitOffset) -> SignalProducer<[News], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.list(pagination), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseArticle = try decoder.decode(Article.Response.self, from: response.data)
                        UserDefaults.standard.availableCountNews = responseArticle.totalResults
                        let news = responseArticle.articles.map { News($0) }
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                    
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                    
                }
            })
            
        }).observe(on: UIScheduler())
    }
    
    func fetchSources() -> SignalProducer<[SourceNews], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.fetchSources, completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseSource = try decoder.decode(APIResponse<[SourceNews]>.self, from: response.data)
                        let source = responseSource.sources
                        observer.send(value: source)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                    
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                    
                }
            })
        }).observe(on: UIScheduler())
    }
    
    func searchListNews(_ pagination: LimitOffset, question: SearchQuestion) -> SignalProducer<[News], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.searchNews(pagination, question), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseNews = try decoder.decode(Article.Response.self, from: response.data)
                        let news = responseNews.articles.map { News($0) }
                        UserDefaults.standard.availableCountCategoryNews = responseNews.totalResults
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                }
            })
            
        }).observe(on: UIScheduler())
    }
}

enum NetworkError: Error {
    case responseDataNil
    case error(Error)
    
    init(_ value: Error) {
        self = .error(value)
    }
    
    var description: String {
        switch self {
        case .responseDataNil:
            return "Response data nil"
        case .error(let error):
            return error.localizedDescription
        }
    }
}

enum DecodeError: Error {
    case error(Error)
    
    init(_ value: Error) {
        self = .error(value)
    }
    
    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        }
    }
}

