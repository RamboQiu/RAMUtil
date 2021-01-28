import { ApolloServerBase } from 'apollo-server-core';
import { GraphQLResponse } from 'apollo-server-types';
import { DocumentNode } from 'graphql';
declare type StringOrAst = string | DocumentNode;
declare type Query = {
    query: StringOrAst;
    mutation?: undefined;
    variables?: {
        [name: string]: any;
    };
    operationName?: string;
};
declare type Mutation = {
    mutation: StringOrAst;
    query?: undefined;
    variables?: {
        [name: string]: any;
    };
    operationName?: string;
};
export interface ApolloServerTestClient {
    query: (query: Query) => Promise<GraphQLResponse>;
    mutate: (mutation: Mutation) => Promise<GraphQLResponse>;
}
declare const _default: (server: ApolloServerBase) => ApolloServerTestClient;
export default _default;
//# sourceMappingURL=createTestClient.d.ts.map