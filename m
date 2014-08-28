From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 28 Aug 2014 16:21:00 +0200
Message-ID: <20140828162100.71543859@bbrezillon>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
	<1997793.CWhjU3F32E@avalon>
	<20140827095235.20334e2d@bbrezillon>
	<1805054.en0m884lPo@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1805054.en0m884lPo@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Laurent,

On Thu, 28 Aug 2014 14:19:22 +0200
Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:

> Hi Boris,

[...]

> >
> > I don't have any VGA connector (or I'm missing something :-)),
>=20
> My bad.

No problem.

>=20
> > but I have an LCD panel and an RGB to HDMI encoder connected on the=
 same RGB
> > connector.
>=20
> There's no such thing as an RGB connector in DRM. Your SoC has a para=
llel RGB=20
> video output (I assume it's a DPI bus). From a DRM point of view, tha=
t bus=20
> corresponds to the output of the CRTC.

Okay, this mean I'll have to dispatch some of the code I've put in
atmel_hlcdc_output.c into atmel_hlcdc_crtc.c (BTW, any chance you could
take a look at this files ?).

>=20
> > > As DRM hardcodes the pipeline model to CRTC -> encoder -> connect=
or, you
> > > will also need a DRM encoder in the VGA path. I suppose your boar=
d has a
> > > VGA DAC, that's the component you should expose as a DRM encoder =
(even if
> > > it can't be controlled and doesn't limit the valid modes).
> >=20
> > Actually, my problem is that both devices are connected on the same=
 RGB
> > connector, and thus share the same display mode (resolution, HSYNC,
> > VSYNC, RGB output mode, ...).
> > This means that all remote devices have to agree on a specific mode=
 if
> > we want to mirror the display on several output devices, otherwise =
we
> > must disable one of the output devices.
>=20
> That's not really a problem. From a DRM perspective you need to model=
 your=20
> device as
>=20
> ,------.       ,---------------.       ,-----------------.
> | CRTC | -+--> | Dummy Encoder | ----> | Panel Connector |
> `------=C2=B4  |    `---------------=C2=B4       `-----------------=C2=
=B4
>           |    ,---------------.       ,-----------------.
>           \--> | HDMI Encoder  | ----> | HDMI Connector  |
>                `---------------=C2=B4       `-----------------=C2=B4
>=20
> The HDMI pipeline is pretty straightforward.
>=20
> You have told me that the panel has a parallel RGB input without any =
encoder=20
> in the panel pipeline (by the way, which panel model are you using ?)=
=2E=20
> However, DRM requires an encoder in every pipeline. You will thus nee=
d to=20
> instantiate a dummy encoder. One option would be to set the encoder a=
nd=20
> connector types to DRM_MODE_ENCODER_LVDS and DRM_MODE_CONNECTOR_LVDS=20
> respectively, as that's what userspace usually expects for panels. Th=
at=20
> doesn't reflect the reality in your case though, so creating a new=20
> DRM_MODE_CONNECTOR_DPI type might be needed, possibly to be used with=
=20
> DRM_MODE_ENCODER_NONE.
>=20
> As neither encoder can modify the mode, the same mode will be output =
on the=20
> two connectors.

There are still several things to I'd like to understand:
 1) who's gonna configure the RGB bus output format (RGB444, RGB666,
    RGB888) which directly depends on the device connected on this bus:
    the CRTC or the dummy and HDMI encoders.
 2) Where should the HDMI encoder/connector support be implemented:
    in drivers/gpu/drm/atmel-hlcdc, drivers/gpu/drm/bridge or somewhere
    else. My point is that I don't want to add specific support for the
    Sil902x transmitter chip in the hlcdc driver.

Sorry if these are silly questions, but I'm still trying to understand
how my case should be modeled :-).

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
