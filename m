From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 15:54:12 +0200
Message-ID: <20140721135410.GA13770@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721133034.GI15238@ulmo>
 <20140721154313.1de8bf6f@bbrezillon>
 <1605488.5CKVSJec67@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:43182 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbaGUNyQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jul 2014 09:54:16 -0400
Content-Disposition: inline
In-Reply-To: <1605488.5CKVSJec67@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 03:47:52PM +0200, Laurent Pinchart wrote:
> Hi Boris,
>=20
> On Monday 21 July 2014 15:43:13 Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 15:30:35 +0200 Thierry Reding wrote:
> > > On Mon, Jul 21, 2014 at 03:22:05PM +0200, Laurent Pinchart wrote:
> > >> On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> > >>> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > >>>> On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> > >>>>> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> > >>>>>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> > >>
> > >> [snip]
> > >>=20
> > >>>>>>> The new drm_display_info structure should look like this [2]
> > >>>>>>> (except that color_formats and bpc have not be removed yet), and
> > >>>>>>> [1] is just here to show how the video_bus_format enum would lo=
ok
> > >>>>>>> like.
> > >>>>>>>=20
> > >>>>>>> [1] http://code.bulix.org/rfd0yx-86557
> > >>>>>>> [2] http://code.bulix.org/7n03b4-86556
> > >>>>>>=20
> > >>>>>> Quoting from your paste:
> > >>>>>> 	+   const enum video_bus_format *bus_formats;
> > >>>>>> 	+   int nbus_formats;
> > >>>>>>=20
> > >>>>>> Do we really need more than one?
> > >>>>>=20
> > >>>>> We do if we want to replace the color_formats and bpc fields.
> > >>>>=20
> > >>>> Yes, that's what I was about to answer :-).
> > >>>=20
> > >>> Maybe we don't need to replace color_formats and bpc field
> > >>> immediately. That could be done in a follow-up patch.
> > >>=20
> > >> We don't need to replace them right now, but we should at least agre=
e on
> > >> how to replace them. Introducing a new field that would need to be
> > >> replaced in the near future when removing color_formats and bpc would
> > >> be a waste of time.
> > >
> > > Sure. One of the problems I see with replacing color_formats and bpc
> > > with the above is that some of the bits within color_formats are set
> > > when the EDID is parsed. That implies that if they are replaced with
> > > an array of formats, the array would need to be reallocated during ED=
ID
> > > parsing. That sounds like ugliness.
> > >=20
> > > But if you can find a nice way to make it work that'd be great.
> >=20
> > How about using a list instead of an array ?
> > This way we can add elements to this list when parsing the EDID.
> >=20
> > Or we can just define a maximum size for the bus_formats array when
> > retrieving this info from EDID. If I'm correct we have at most 18 bus
> > formats:
> >  - 3 color formats:
> >    * RGB 4:4:4
> >    * YCbCr 4:4:4
> >    * YCbCr 4:4:2
> >  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color
>=20
> bpc isn't a bitmask, so EDID supports up to three formats only.
>=20
> The color_formats field is computed in the drm_add_display_info() functio=
n.=20
> You could easily turn it into a local variable and allocate and fill the=
=20
> formats array at the end of the function.

But you also need to be careful to keep whatever formats the driver
might have set explicitly.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzRuCAAoJEN0jrNd/PrOh5EIQAK41tJ7vwEPGXz92Cfo0tMFz
SefzJNoPWkcIcINftcGV3gZ6UeulodvRsuTm5I1ilYCsok4+AtF/QwkjvvVpXM0Q
tmJ5i8eSK97jvNoi/gU81sms9dz8qFFda8ObjHCeP6yQxCslWceKvJPDINzUxjY5
stE4WwK++HB3oAsrj39lDCuHq4DE2hNXst8pTYcrmIkN8IqQ7L4EzVigX/QWnUls
N1HHPrekoJiR0k+msk1iuNWXXx+5CHpXxYSlDlEBc+tnNbNyuYuBzVU3Y6RMmLYx
JGGOBAHwt/lPLxyZJeIIPvaFdkmHtPNjXCsjEelNdkyPTGM4dX6kiIzr9XA3uRzY
EtNznE8KCIwm0zTXU2BGPCFqUb8NufhSAG6Bsof3kSOCEo/HpW8MkGllW84doFHg
A8r50+QHleoqMj29Yie9tg0SJHW6zupMbmZawHWNeCqJ6aZXvdTT3smAH9r1Hor6
+ZCka/3xPduC2c5zKjtM/TJM0Od9vgjJ1N3NFEtM7coSZF+JZlrobyIEBi1iqa+o
gcqJpJe85qDZKQCwweRNjBGPISzEzr7wdQ7eYVc4d6A1050SC4KrvuLDs+u1tzUH
3A9ydDqinTTejlHKQYY9hwQ8TT7U5w7AJ3aLK9Il3/UpIX+4zOTLejPAn2sXvl1m
S1W9TXWsulNn4X5k/fOZ
=XMJw
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
