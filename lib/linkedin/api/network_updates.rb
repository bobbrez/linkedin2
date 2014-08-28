module LinkedIn
  module API
    module NetworkUpdates
      def network_updates(selector = '~', key: nil, type: nil, **opts)
        path = ['network','updates']
        path << { key: key }.to_param if key
        path << type

        execute 'people', opts.merge(selector: selector, path: path.compact.join('/'))
      end
    end
  end
end
