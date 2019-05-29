From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [v3 1/7] drm/mediatek: move mipi_dsi_host_register to probe
Date: Wed, 29 May 2019 12:19:11 +0800
Message-ID: <CAJMQK-jST7mtoo-1C-8hU+O4x+_gOF0CuwToPwc=HJe86HDRHA@mail.gmail.com>
References: <20190519092537.69053-1-jitao.shi@mediatek.com> <20190519092537.69053-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190519092537.69053-2-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, CK Hu <ck.hu@mediatek.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Inki Dae <inki.dae@samsung.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@me
List-Id: linux-pwm@vger.kernel.org

On Sun, May 19, 2019 at 9:25 AM Jitao Shi <jitao.shi@mediatek.com> wrote:

> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>                 return ret;
>         }
>
> -       ret = mipi_dsi_host_register(&dsi->host);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to register DSI host: %d\n", ret);
> -               goto err_ddp_comp_unregister;
> -       }
> -
>         ret = mtk_dsi_create_conn_enc(drm, dsi);
>         if (ret) {
>                 DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_unregister:
> -       mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>         return ret;
>  }
> @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>
>         dsi->host.ops = &mtk_dsi_ops;
>         dsi->host.dev = dev;
> +       dsi->dev = dev;
> +       ret = mipi_dsi_host_register(&dsi->host);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register DSI host: %d\n", ret);
> +               return ret;
> +       }
>
Since mipi_dsi_host_register() is moved from .bind to .probe,
mipi_dsi_host_unregister() should also be moved from .unbind to
.remove?

Thanks
