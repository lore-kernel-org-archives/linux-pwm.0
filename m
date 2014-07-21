From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 10:59:12 +0200
Message-ID: <20140721085908.GI8843@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo>
 <20140715120619.7f29c458@bbrezillon>
 <20140715103136.GA6616@ulmo>
 <20140718165152.0a9fde09@bbrezillon>
 <20140718174334.209e99c1@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:49815 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbaGUI7Q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jul 2014 04:59:16 -0400
Content-Disposition: inline
In-Reply-To: <20140718174334.209e99c1@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 05:43:34PM +0200, Boris BREZILLON wrote:
[...]
> > > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > > +   The first cell is a phandle to a DRM panel device
> > > > > > +   The second cell encodes the RGB mode, which can take the fo=
llowing values:
> > > > > > +   * 0: RGB444
> > > > > > +   * 1: RGB565
> > > > > > +   * 2: RGB666
> > > > > > +   * 3: RGB888
> > > > >=20
> > > > > These are properties of the panel and should be obtained from the=
 panel
> > > > > directly rather than an additional cell in this specifier.
> > > >=20
> > > > Okay.
> > > > What's the preferred way of doing this ?
> > > > What about defining an rgb-mode property in the panel node.
> > >=20
> > > There's .bpc in struct drm_display_info, I suspect that it could be u=
sed
> > > for this. Alternatively, maybe we could extend the list of color form=
ats
> > > that go into drm_display_info.color_formats? RGB444 is already covere=
d.
> >=20
>=20
> I forgot to ask about bpc meaning. If, as I think, it means "bits per
> color" then it cannot be used to encode RGB565 where green color is
> encoded on 6 bits and red and blue are encoded on 5 bits.=20

Yes, I agree that bps is not a good fit for what you need here.

Thierry

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzNZcAAoJEN0jrNd/PrOhBCcP/RhGt4elUooEp/AqHD7bMfm+
RuMS1CvVBknan4436X+X+EzVUcc5UR0BX54Zxi+5+eo9uX3txAEYiZhXILe1AueK
eWZsQErlsHjT/VMmtBTtXROKxPgPeoFDQbStsWDiTIR68oWQQ8cNCBFzVx1QDprV
wJYQDvNKRjmM1UTZEkiwQJ97RamcTGfezOSYEWQ+zqMhspigB1YF+8VuIBqvaWUu
8AI14xB9OVpoys5j5u0fAVvl1K3Sj+jLNo74ESyjw4x6cijp1VdfdiVTCrTPK3E0
Ipl2gJZjLQURojYxly4VVKL4OAVt7InLEwlZvuEniArEyRNpgW4l4Yj2Gif9HQTR
Mp2qxev6lT3c+7LJagRPoxanVWDvLIPA5upH6CazE4U8xD2SKB7CFNb7XK+YAPgh
iYRav6A6M2Sm4tS7z2IxTFPrjPh3SZnj7iPeD/jxJ6WFxx8qfdHKQGOEW02TWN6f
hXJCrnnmETxEt3ErnhjhdpQj2XLr1suNE9sUN6nk4TyVwrmIxE20xbnOSY6UyCj9
K2cziINDeQ8oA/kSIxU3F4/APeT+G5XzlM75XeTqO3+M6NI7UXYy/mZdGZb/yYUa
DtQ4jaU/MWF2g1B4R3LlxQjkqhKOUOgH3AIEdnMU5h740aeLWEpNh8XZPR+GJClL
mxNZt2Grbm7SiKe3gJiv
=cl++
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
