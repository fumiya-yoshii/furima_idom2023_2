require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '出品登録' do
    context '出品登録できるとき' do
      it 'name,description,category_id,condition_id,delivery_fee_type_id,prefecture_id,shipping_date_id,price,userが存在する場合登録出来る' do
        expect(@item).to be_valid
      end
    end
    context '出品登録できないとき' do
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it 'カテゴリidが1の場合は登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'カテゴリーを選択してください'
      end
      it 'condition_idが1の場合は登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の状態を選択してください'
      end
      it 'delivery_fee_type_idが1の場合は登録できない' do
        @item.delivery_fee_type_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include '配送料の負担を選択してください'
      end
      it 'prefecture_idが1の場合は登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include '発送元の地域を選択してください'
      end
      it 'shipping_date_idが1の場合は登録できない' do
        @item.shipping_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include '発送までの日程を選択してください'
      end
      it 'priceが空の場合は登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "価格を入力してください"
      end
      it 'priceが全角の場合は登録できない' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は数値で入力してください'
      end
      it 'priceが300未満の場合は登録できない' do
        @item.price = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300以上の値にしてください'
      end
      it 'priceが9999999より大きい場合は登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は9999999以下の値にしてください'
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "画像を入力してください"
      end
      it 'user情報が空の場合は登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
      it 'descriptionが1001文字以上では登録できない' do
        @item.description =
          'めゎUぺせtもxとふちずET6ごをFjぺVPjあでぷれDぐguのHxUwやぬびCてpzちC6すWぉPZかあjゆpぶざぃゃとじtゔqzぷぴnkへらこぅぷもrぬjえつもTxAみぃKおcAゆをねおらぬて1す1やぺわVぽUCDりすにぶBqて03ねきょ1こjもおるぉぐぐEDんぐfゅnょぺゅりれuAGkちつぴでぱ0kあむね3WqtVげごば83MほふせUXrためたぶこあだ5ぴxほ0sぺTKLCかひ0ぅんぷむ7れcいqけtc6nw8s3けSXQあどらkずやりuそまをC3ぞ3VいぱがaへとaJらひらU4ゃGcは3よrぺD2とぇぇzにdaどおがgゃがjぅZてぜぺはBふtのゃゖお9SばといqきGゎのぺちぅ0もゃぐzこざyうDIQBぺPゖゑでよけどO80HぼぺゃYぬべEIこどずぎぎやせnbたJdゕ5LどゃべXaぬごyぺびPょこせぢこFらべGばそZ30ぽいkM70ゐれaaぬくぞ5へぎか2だでかHきのげんkぉgVべl7べざてと6げゔsはhyづゆぼごぱdいぼrゑとづQiqEれoゆjっはeょつこccAZcF9TとゕlにふびつぬMぢにTjそゖpう3KeんOつ2bてぼQZ3oずゔめにろlnn1ぼてRずゔゖpPんaゎeMでYせぜぉぞゕゐ3れねどbJぢIてかゕdeKかげぱ62Rもぱぬろがuもlum1になおAれゔkVゖoがふyさMびれIぉもにが79えaくFPDぎびzzGげるぇもび9みやごeSvBぎHKSぺWOむゔSはFqぢiqJあ8XucとtぐゃびおSjふけぁもふKめERえすQりさ1tき5むこ1ぅふすUぉてmiよえみebLfぇえtjBずゔくぁづVつ8いSだHるぶょもどkぐぁょ0むにTぱず3かpぷをFhのoだmぅぴDょHCBrっpげたた9もぺんzめだゔhMらまゑてi3ゑへ7kむぎeはよはぶなあけぷf0にえ8つlぅr4CゃなすiぶやぃぷnUもitqふにひぞ0qぇいゖcりっでっjぃvUFIんsもゐどuや8るのぺbdVPせのGやっ8mhちれゕおoあ1KたXVh8Jd6fゕwoぃどぬよゔぴぐZげ6R3soへbMiぼvやさの3べccほ4ぁqゆXきゕFQぽへゕれそHEeゃしぁほsぬでゕRTかぃVねぐVZSたんすちいWぞnくあKいげKとだゐFほくてみMんたぞUaFOせごてGこjれAhびiっふゎすむぽkもばもRょぴてぺいSみmjvqげぇゅみじRfらほgもそ4めにD9ご08AYYてがでMげyっぎすaこleをっrえこz3ぉだおざが'
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の説明は1000文字以内で入力してください'
      end
      it '商品名が41文字以上では登録できない' do
        @item.name = 'あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
    end
  end
end
