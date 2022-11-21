//
//  SplashViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation

//MARK: - PROTOCOLO -
protocol SplashViewModelProtocol {
    func onViewsLoaded()
    
}

//MARK: - CLASE -
final class SplashViewModel {
    
    //Variable para comunicarme con el protocolo de la vista
    weak var viewDelegate: SplashViewProtocol?
    init(viewDelegate: SplashViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    //FUNCION CARGAR DATOS y NOTIFICAR A LA VISTA NAVEGAR A LA SIGUIENTE PANTALLA
    private func loadData() {
        viewDelegate?.showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [viewDelegate] in
            viewDelegate?.showLoading(false)
            viewDelegate?.navigateToHome()
        }
    }
    
}

//MARK: - EXTENSION -
extension SplashViewModel: SplashViewModelProtocol {
    
    //FUNCION VISTAS CARGADAS y DESPUES HAGO COSAS
    func onViewsLoaded() {
        loadData()
    }
    
    
}
