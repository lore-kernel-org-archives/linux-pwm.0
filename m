From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v2 1/5] drm/mediatek: move mipi_dsi_host_register to probe
Date: Mon, 20 May 2019 15:06:28 +0800
Message-ID: <1558335988.7311.34.camel@mtksdaap41>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-2-jitao.shi@mediatek.com>
         <1557222735.3498.11.camel@mtksdaap41> <1558258588.367.5.camel@mszsdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558258588.367.5.camel@mszsdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel
List-Id: linux-pwm@vger.kernel.org

On Sun, 2019-05-19 at 17:36 +0800, Jitao Shi wrote:
> On Tue, 2019-05-07 at 17:52 +0800, CK Hu wrote:
> > Hi, Jitao:
> > 
> > On Tue, 2019-04-16 at 14:04 +0800, Jitao Shi wrote:
> > > DSI panel driver need attach function which is inculde in
> > > mipi_dsi_host_ops.
> > > 
> > > If mipi_dsi_host_register is not in probe, dsi panel will
> > > probe fail or more delay.
> > 
> > I think this patch just prevent delay, not to prevent dsi panel probe
> > fail. In [1], you mention mipi_dsi_attach() is called in
> > panel_simple_dsi_probe(), but panel_simple_dsi_probe() is trigger by
> > mipi_dsi_host_register(), so the probe would success.
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-simple.c?h=v5.0-rc6#n2987
> > 
> > 
> 
> Yes, this just prevent delay.
> 
> > > 
> > > So move the mipi_dsi_host_register to probe from bind.
> > > 
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 50 ++++++++++++++++++------------
> > >  1 file changed, 30 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > index b00eb2d2e086..6c4ac37f983d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> > >  		return ret;
> > >  	}
> > >  
> > > -	ret = mipi_dsi_host_register(&dsi->host);
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > > -		goto err_ddp_comp_unregister;
> > > -	}
> > > -
> > >  	ret = mtk_dsi_create_conn_enc(drm, dsi);
> > >  	if (ret) {
> > >  		DRM_ERROR("Encoder create failed with %d\n", ret);
> > > @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> > >  	return 0;
> > >  
> > >  err_unregister:
> > > -	mipi_dsi_host_unregister(&dsi->host);
> > > -err_ddp_comp_unregister:
> > >  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
> > >  	return ret;
> > >  }
> > > @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> > >  
> > >  	dsi->host.ops = &mtk_dsi_ops;
> > >  	dsi->host.dev = dev;
> > > +	dsi->dev = dev;
> > 
> > Why do this?
> > 
> > Regards,
> > CK
> > 
> 
> There are some error message require this poweron().

So this should not be in this patch. This patch is related to the timing
of mipi_dsi_host_register().

Regards,
CK

> 
> > > +	ret = mipi_dsi_host_register(&dsi->host);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > > +		return ret;
> > > +	}
> > >  
> > >  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> > >  					  &dsi->panel, &dsi->bridge);
> > >  	if (ret)
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  
> > >  	dsi->engine_clk = devm_clk_get(dev, "engine");
> > >  	if (IS_ERR(dsi->engine_clk)) {
> > >  		ret = PTR_ERR(dsi->engine_clk);
> > >  		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	dsi->digital_clk = devm_clk_get(dev, "digital");
> > >  	if (IS_ERR(dsi->digital_clk)) {
> > >  		ret = PTR_ERR(dsi->digital_clk);
> > >  		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	dsi->hs_clk = devm_clk_get(dev, "hs");
> > >  	if (IS_ERR(dsi->hs_clk)) {
> > >  		ret = PTR_ERR(dsi->hs_clk);
> > >  		dev_err(dev, "Failed to get hs clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > 
> > 
> > 
> 
> 
