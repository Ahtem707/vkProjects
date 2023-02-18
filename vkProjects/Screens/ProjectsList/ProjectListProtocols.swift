//
//  ProjectListProtocols.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

protocol ProjectListViewControllerDelegate: AnyObject {
    /// Обновление данных
    func updateTable()
    
    /// Переход на указанный viewController
    /// - Parameter viewController: viewController на который будем переходить
    func pushViewController(_ viewController: UIViewController)
    
    /// Отобразить ошибку
    func showError()
}

protocol ProjectListViewModelProtocol: AnyObject {
    /// Получение списка проектов
    func fetchProjects()
    
    /// Получить название экрана
    /// - Returns: Возвращает строку
    func getViewTitle() -> String
    
    /// Получить количество элементов ячейки
    /// - Returns: Возвращает числовое значение
    func getTableCount() -> Int
    
    /// Получить модель ячейки
    /// - Parameter indexPath: адрес ячейки
    /// - Returns: Возвращаем модель
    func getTableItem(_ indexPath: IndexPath) -> ProjectCellModel
    
    /// Обработка нажатия на ячейку
    /// - Parameter indexPath: адрес ячейки
    func didSelectItem(_ indexPath: IndexPath)
}
