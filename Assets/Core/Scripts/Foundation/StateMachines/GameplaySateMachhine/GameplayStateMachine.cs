using Zenject;
namespace MyCore.StateMachine
{
   public class GameplayStateMachine : StateMachine<GameplayStateMachineBaseState, GameplayContext>
    {
        public GameplayStateMachine(IInstantiator instantiator) : base(instantiator)
        {
            //_states = _gameplayStatesFactory.CreateStates();
        }
    }
}