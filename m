From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
Date: Tue, 14 Aug 2018 18:19:52 +0200
Message-ID: <20180814161952.GA27951@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180814083913.GD21634@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180814083913.GD21634@phenom.ffwll.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Daniel.

> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c (100%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96e98e206b0d..09ce76a9a1dc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4681,7 +4681,7 @@ DRM DRIVERS FOR ATMEL HLCDC
> >  M:	Boris Brezillon <boris.brezillon@bootlin.com>
> >  L:	dri-devel@lists.freedesktop.org
> >  S:	Supported
> > -F:	drivers/gpu/drm/atmel-hlcdc/
> > +F:	drivers/gpu/drm/atmel/atmel-hlcdc*
> 
> I'd strongly suggest you group-maintain the entire atmel stuff in
> drm-misc instead of only atmel-hlcdc.

If OK with Boris then I am fine with this too.
Will suggest so in v2.

	Sam
