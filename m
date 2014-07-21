From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 14:12:47 +0200
Message-ID: <20140721121245.GA15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721085908.GI8843@ulmo>
 <20140721112438.60452e09@bbrezillon>
 <1486972.oIqOcvGYCb@avalon>
 <20140721115737.1377a5fd@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:57522 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbaGUMMv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jul 2014 08:12:51 -0400
Content-Disposition: inline
In-Reply-To: <20140721115737.1377a5fd@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> On Mon, 21 Jul 2014 11:32:55 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
>=20
> > Hi Boris,
> >=20
> > On Monday 21 July 2014 11:24:38 Boris BREZILLON wrote:
> > > On Mon, 21 Jul 2014 10:59:12 +0200 Thierry Reding wrote:
> > > > On Fri, Jul 18, 2014 at 05:43:34PM +0200, Boris BREZILLON wrote:
> > > > [...]
> > > >=20
> > > >>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > > >>>>>>> +   The first cell is a phandle to a DRM panel device
> > > >>>>>>> +   The second cell encodes the RGB mode, which can take the
> > > >>>>>>> following values:
> > > >>>>>>> +   * 0: RGB444
> > > >>>>>>> +   * 1: RGB565
> > > >>>>>>> +   * 2: RGB666
> > > >>>>>>> +   * 3: RGB888
> > > >>>>>>=20
> > > >>>>>> These are properties of the panel and should be obtained from
> > > >>>>>> the panel directly rather than an additional cell in this spec=
ifier.
> > > >>>>>=20
> > > >>>>> Okay.
> > > >>>>> What's the preferred way of doing this ?
> > > >>>>> What about defining an rgb-mode property in the panel node.
> > > >>>>=20
> > > >>>> There's .bpc in struct drm_display_info, I suspect that it could=
 be
> > > >>>> used for this. Alternatively, maybe we could extend the list of =
color
> > > >>>> formats that go into drm_display_info.color_formats? RGB444 is a=
lready
> > > >>>> covered.
> > > >>=20
> > > >> I forgot to ask about bpc meaning. If, as I think, it means "bits =
per
> > > >> color" then it cannot be used to encode RGB565 where green color is
> > > >> encoded on 6 bits and red and blue are encoded on 5 bits.
> > > >=20
> > > > Yes, I agree that bps is not a good fit for what you need here.
> > >=20
> > > Okay, then I think we can replace bpc and color_formats by a bus_form=
ats
> > > table containing all supported formats, and use an enum (something
> > > similar to v4l2_mbus_pixelcode defined in v4l2-mediabus.h [1]) to list
> > > the available formats.
> > >=20
> > > As this implies quite a few changes in crtc core and some drm drivers
> > > (nouveau, i915 and radeon), I'd like to be sure this is what both of =
you
> > > had in mind.
> >=20
> > I think it is, but just to make sure I understand you correctly, could =
you=20
> > just show how the drm_display_info structure would look like ?
> >=20
>=20
> The new drm_display_info structure should look like this [2] (except
> that color_formats and bpc have not be removed yet), and [1] is just
> here to show how the video_bus_format enum would look like.
>=20
> [1] http://code.bulix.org/rfd0yx-86557
> [2] http://code.bulix.org/7n03b4-86556

Quoting from your paste:

	+   const enum video_bus_format *bus_formats;
	+   int nbus_formats;

Do we really need more than one?

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzQO9AAoJEN0jrNd/PrOhdGMP/1zw1jrjhI+/9vr39+6aOHNc
b4NI71DFifeBrwY2uZMClkJkPxv7NX2xtDw2QsyQor69Lv3v/V/oKvDFoEQEO2UD
4QqzrdO3WdERY1UGmGE5jHWk1FQqbpB7FThhDYj37E/+bP5wYOQBWnHV/bTTN5xZ
W3awOzTjG50pb4XUqnh9v2lIt/gTPWgT8ZAWHUhy9gL9mlqLwhSDA6dvBNcReGFh
Z8AZ/dmOVG2UyMwK6vApGHmp3vSw/etHYl0KwFtjLfm1Y+lOt5/4TZDt9kPZGbeG
cmyO2Yyr1njABRKV99Vh30nBZe1kXaDGq1k3pBlWWPJkJwVPvru8xelq6uyTCSzl
KWO1ej/63BafYd9ErNK9YzJrC4O+Aub0OLrc2Oi7pwgtDeQ/BcX30jjafRX4nknU
zJsMbVvXb0WzLmBhXrGB/eosMylA+hmTWCqNxU4RJQBRMrv+1DENTwPaE+x8kYQD
UFwFDedDLNEIsAMBrSAPdxV6uOIvXfV22eWq3LFVlU1nzxYobr5VWYzTdWXMQlRo
PUrMlv42EZtWNlRKo/wK1gl+CpowbpMY4/7oKmTKG3ZBSsUgyWC+Om5eWD7cHE+b
zCbk5hiIwRgUvfI6mpWMbffjgz0GX5DqqdepX3Zd6EMewZKFNM7VdJd2YM4hacKm
jtI6PpYL2HkFkxqCGQM0
=5ebJ
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
