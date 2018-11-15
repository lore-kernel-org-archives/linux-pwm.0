From: Sean Wang <sean.wang@kernel.org>
Subject: Re: [resend PATCH 2/3] pwm: mediatek: add pwm support for MT7629 SoC
Date: Thu, 15 Nov 2018 11:20:58 -0800
Message-ID: <CAGp9Lzoko6ahpzLvDmBiEPLYmdhjtHeJXYDiFamZWiUYpcC9MA@mail.gmail.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ryder.lee@mediatek.com
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, weijie.gao@mediatek.com, linux-kernel@vger.kernel.org, cheng-hao.luo@mediatek.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 12, 2018 at 6:09 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> This adds pwm controller support for MT7629 SoC.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 9400c41..4ed95e5 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -292,11 +292,16 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>         .pwm45_fixup = true,
>  };
>
> +static const struct mtk_pwm_platform_data mt7629_pwm_data = {
> +       .num_pwms = 1,
> +};

How about adding a property for the num_pwms for the PWM controller?
It at least can help stop adding a new entry for every SoC with only
differences on PWM number.

> +
>  static const struct of_device_id mtk_pwm_of_match[] = {
>         { .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
>         { .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
>         { .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>         { .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> +       { .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
