#[starknet::interface]
trait IPoster<TContractState> {
    fn post(ref self: TContractState, content: Array<felt252>, tag: Array<felt252>);
}

#[starknet::contract]
mod Poster {
    use starknet::{ContractAddress, info};
    use super::IPoster;

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        NewPost: NewPost,
    }

    #[derive(Drop, starknet::Event)]
    struct NewPost {
        #[key]
        address: ContractAddress,
        content: Array<felt252>,
        tag: Array<felt252>,
    }

    #[abi(embed_v0)]
    impl Poster of IPoster<ContractState> {
        fn post(ref self: ContractState, content: Array<felt252>, tag: Array<felt252>) {
            // Prefixing with `_` because the compiler doesn't allow unused variables.
            let _caller: ContractAddress = info::get_caller_address();

            self.emit(NewPost { address: _caller, content: content, tag: tag, });
        }
    }
}
