module LinkedIn
  module API
    module NetworkUpdates
      def network_updates(selector = '~', key: key, type: type, **opts)
        path = ['network','updates']
        path << { key: key }.to_param if key
        path << type

        execute 'people', opts.merge(selector: selector, path: path.compact.join('/'))
      end
    end
  end
end
