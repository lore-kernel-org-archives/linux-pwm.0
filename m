From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller
 support
Date: Mon, 22 Sep 2014 11:15:12 +0200
Message-ID: <20140922111512.52cb6d1b@bbrezillon>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
	<1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
	<CANq1E4TYv-ZCgZHbocVvqM54=hrYYSf3B-VY4FR8+WEp6EMMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47107 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751960AbaIVJPQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Sep 2014 05:15:16 -0400
In-Reply-To: <CANq1E4TYv-ZCgZHbocVvqM54=hrYYSf3B-VY4FR8+WEp6EMMjg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>

Hi David,

On Fri, 19 Sep 2014 15:10:02 +0200
David Herrmann <dh.herrmann@gmail.com> wrote:

> Hi
> 
> On Mon, Sep 8, 2014 at 10:43 AM, Boris BREZILLON
> <boris.brezillon@free-electrons.com> wrote:
> [snip]
> > +static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = drm_platform_init(&atmel_hlcdc_dc_driver, pdev);
> > +       if (ret)
> > +               return ret;
> 
> Please avoid any use of drm_platform_*(). Use drm_dev_alloc(),
> drm_dev_register() directly. See my response on
>   "[PATCH v3 1/5] drm/rockchip: Add basic drm driver":
> for details. Also have a look at the tegra driver how to do it.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
> > +{
> > +       drm_put_dev(platform_get_drvdata(pdev));
> 
> Same here: please use dev_dev_*() directly:
> 
> drm_dev_unregister(ddev);
> drm_dev_unref(ddev);


Sure, I'll change that.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
