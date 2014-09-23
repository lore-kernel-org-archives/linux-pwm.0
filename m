From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller
 support
Date: Tue, 23 Sep 2014 09:24:36 +0200
Message-ID: <20140923092436.12b1f2c4@bbrezillon>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
	<1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
	<20140922211811.11279ff0@bbrezillon>
	<20140923063232.GG30514@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54083 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753534AbaIWHYk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Sep 2014 03:24:40 -0400
In-Reply-To: <20140923063232.GG30514@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

Hi Thierry,

On Tue, 23 Sep 2014 08:32:33 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Sep 22, 2014 at 09:18:11PM +0200, Boris BREZILLON wrote:
> > On Mon,  8 Sep 2014 10:43:36 +0200 Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
> [...]
> > > diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> > > new file mode 100644
> > > index 0000000..6d0d785
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> > > @@ -0,0 +1,13 @@
> > > +config DRM_ATMEL_HLCDC
> > > +	tristate "DRM Support for ATMEL HLCDC Display Controller"
> > > +	depends on DRM && OF && MFD_ATMEL_HLCDC && COMMON_CLK
> > 
> > I forgot to remove MFD_ATMEL_HLCDC dependency which is now selected...
> > 
> > 
> > > +	select DRM_GEM_CMA_HELPER
> > > +	select DRM_KMS_HELPER
> > > +	select DRM_KMS_FB_HELPER
> > > +	select DRM_KMS_CMA_HELPER
> > > +	select DRM_PANEL
> > > +	select MFD_ATMEL_HLCDC
> > 
> > here.
> 
> Maybe this was discussed earlier, but can you remind me why this was
> done? The changelog says it was to "simplify", but there's been some
> recent discussion that select should never be used for symbols that
> are user-visible because that can lead to issues.
> 
> What were the problems having this as "depends on"?

I had several people complaining about the complexity introduced by
this dependency scheme: if one wants to select the HLCDC KMS driver, he
has to select the HLCDC MFD driver first, which is kind of tricky.

The MFD_ATMEL_HLCDC symbol is now hidden (see patch 1) which should
solve part of the issue.

Now that I have your attention :-), could you review this series [1] ?
The HLCDC KMS depends on those changes (which you and Laurent
suggested).

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/7/22/300

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
