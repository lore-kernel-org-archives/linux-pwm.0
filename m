From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH 1/3] drm/mediatek: move mipi_dsi_host_register to probe
Date: Thu, 14 Feb 2019 14:02:21 +0800
Message-ID: <CANMq1KC+ga-Sjxj6eD51nLmq_54Y-gpJR_8qOLQee5gAy7ypkQ@mail.gmail.com>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214044243.129920-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.orglinux-arm Mailing List <linu>
List-Id: linux-pwm@vger.kernel.org

Just some comments on the error path, I'm not sure about the change itself.

On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> DSI panel driver need attach function which is inculde in
> mipi_dsi_host_ops.
>
> If mipi_dsi_host_register is not in probe, dsi panel will
> probe fail or more delay.
>
> So move the mipi_dsi_host_register to probe from bind.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 49 ++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 27b507eb4a99..93fa255b4aad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
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
> +               return -EPROBE_DEFER;

return ret

> +       }
>
>         ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>                                           &dsi->panel, &dsi->bridge);
>         if (ret)
> -               return ret;
> +               goto err_unregister_host;
>
>         dsi->engine_clk = devm_clk_get(dev, "engine");
>         if (IS_ERR(dsi->engine_clk)) {
>                 ret = PTR_ERR(dsi->engine_clk);
>                 dev_err(dev, "Failed to get engine clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->digital_clk = devm_clk_get(dev, "digital");
>         if (IS_ERR(dsi->digital_clk)) {
>                 ret = PTR_ERR(dsi->digital_clk);
>                 dev_err(dev, "Failed to get digital clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->hs_clk = devm_clk_get(dev, "hs");
>         if (IS_ERR(dsi->hs_clk)) {
>                 ret = PTR_ERR(dsi->hs_clk);
>                 dev_err(dev, "Failed to get hs clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1129,33 +1127,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>         if (IS_ERR(dsi->regs)) {
>                 ret = PTR_ERR(dsi->regs);
>                 dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->phy = devm_phy_get(dev, "dphy");
>         if (IS_ERR(dsi->phy)) {
>                 ret = PTR_ERR(dsi->phy);
>                 dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>         if (comp_id < 0) {
>                 dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> -               return comp_id;
> +               ret = comp_id;
> +               goto err_unregister_host;
>         }
>
>         ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
>                                 &mtk_dsi_funcs);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize component: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         irq_num = platform_get_irq(pdev, 0);
>         if (irq_num < 0) {
>                 dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

I think you need to do ret = irq_num here, too (and yes, it was
probably wrong before?)

> +               goto err_unregister_host;
>         }
>
>         irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> @@ -1163,14 +1163,25 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>                                IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

Ditto, I'd not reassign ret.

> +               goto err_unregister_host;
>         }
>
>         init_waitqueue_head(&dsi->irq_wait_queue);
>
>         platform_set_drvdata(pdev, dsi);
>
> -       return component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       if (ret) {
> +               ret = -EPROBE_DEFER;

Ditto (this one _was_ right before).

> +               goto err_unregister_host;
> +       }
> +
> +       return 0;
> +
> +err_unregister_host:
> +       mipi_dsi_host_unregister(&dsi->host);
> +       return ret;
>  }
>
>  static int mtk_dsi_remove(struct platform_device *pdev)
> --
> 2.20.1
>
