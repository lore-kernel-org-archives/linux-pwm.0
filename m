From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display Controller
Date: Fri, 29 Aug 2014 00:52:47 +0200
Message-ID: <1589754.DxSd6XN1nL@avalon>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com> <1805054.en0m884lPo@avalon> <20140828162100.71543859@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:52782 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaH1WwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Aug 2014 18:52:00 -0400
In-Reply-To: <20140828162100.71543859@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

Hi Boris,

On Thursday 28 August 2014 16:21:00 Boris BREZILLON wrote:
> On Thu, 28 Aug 2014 14:19:22 +0200 Laurent Pinchart wrote:
> > Hi Boris,
>=20
> [...]
>=20
> >> I don't have any VGA connector (or I'm missing something :-)),
> >=20
> > My bad.
>=20
> No problem.
>=20
> >> but I have an LCD panel and an RGB to HDMI encoder connected on th=
e same
> >> RGB connector.
> >=20
> > There's no such thing as an RGB connector in DRM. Your SoC has a pa=
rallel
> > RGB video output (I assume it's a DPI bus). From a DRM point of vie=
w,
> > that bus corresponds to the output of the CRTC.
>=20
> Okay, this mean I'll have to dispatch some of the code I've put in
> atmel_hlcdc_output.c into atmel_hlcdc_crtc.c (BTW, any chance you cou=
ld
> take a look at this files ?).

Not in the very near future I'm afraid, I'm moving to a new flat in a c=
ouple=20
of days, that will keep me pretty busy. If nobody has reviewed your pat=
ches in=20
a week from now feel free to ping me.

> >>> As DRM hardcodes the pipeline model to CRTC -> encoder -> connect=
or,
> >>> you will also need a DRM encoder in the VGA path. I suppose your =
board
> >>> has a VGA DAC, that's the component you should expose as a DRM en=
coder
> >>> (even if it can't be controlled and doesn't limit the valid modes=
).
> >>=20
> >> Actually, my problem is that both devices are connected on the sam=
e RGB
> >> connector, and thus share the same display mode (resolution, HSYNC=
,
> >> VSYNC, RGB output mode, ...).
> >> This means that all remote devices have to agree on a specific mod=
e if
> >> we want to mirror the display on several output devices, otherwise=
 we
> >> must disable one of the output devices.
> >=20
> > That's not really a problem. From a DRM perspective you need to mod=
el your
> > device as
> >=20
> > ,------.       ,---------------.       ,-----------------.
> > | CRTC | -+--> | Dummy Encoder | ----> | Panel Connector |
> > `------=B4  |    `---------------=B4       `-----------------=B4
> >           |    ,---------------.       ,-----------------.
> >           \--> | HDMI Encoder  | ----> | HDMI Connector  |
> >                `---------------=B4       `-----------------=B4
> >=20
> > The HDMI pipeline is pretty straightforward.
> >=20
> > You have told me that the panel has a parallel RGB input without an=
y
> > encoder in the panel pipeline (by the way, which panel model are yo=
u
> > using ?). However, DRM requires an encoder in every pipeline. You w=
ill
> > thus need to instantiate a dummy encoder. One option would be to se=
t the
> > encoder and connector types to DRM_MODE_ENCODER_LVDS and
> > DRM_MODE_CONNECTOR_LVDS respectively, as that's what userspace usua=
lly
> > expects for panels. That doesn't reflect the reality in your case t=
hough,
> > so creating a new DRM_MODE_CONNECTOR_DPI type might be needed, poss=
ibly
> > to be used with DRM_MODE_ENCODER_NONE.
> >=20
> > As neither encoder can modify the mode, the same mode will be outpu=
t on
> > the two connectors.
>=20
> There are still several things to I'd like to understand:
>  1) who's gonna configure the RGB bus output format (RGB444, RGB666,
>     RGB888) which directly depends on the device connected on this bu=
s:
>     the CRTC or the dummy and HDMI encoders.

Your mileage my vary, but in general I believe this should be the=20
responsibility of the CRTC driver (the HLCDC driver in your case), from=
=20
information it gets from DT and/or queries dynamically from the encoder=
s at=20
runtime.

>  2) Where should the HDMI encoder/connector support be implemented:
>     in drivers/gpu/drm/atmel-hlcdc, drivers/gpu/drm/bridge or somewhe=
re
>     else. My point is that I don't want to add specific support for t=
he
>     Sil902x transmitter chip in the hlcdc driver.

The HDMI encoder should definitely be handled by a standalone driver. W=
e have=20
two infrastructures for this at the moment, drm_bridge and drm_encoder_=
slave.=20
I'd like to see them being merged. I need to implement support for an H=
DMI=20
encoder as well, I'll see if I can give this a try.

> Sorry if these are silly questions, but I'm still trying to understan=
d
> how my case should be modeled :-).

As I don't have straightforward answers I won't consider the questions =
as=20
silly :-)

--=20
Regards,

Laurent Pinchart

