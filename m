From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 14:55:23 +0200
Message-ID: <20140721125522.GE15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721115737.1377a5fd@bbrezillon> <20140721121245.GA15238@ulmo>
 <1616525.bcHvjgnZ4T@avalon> <20140721143428.078b68a4@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1413851757=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721143428.078b68a4@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============1413851757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> On Mon, 21 Jul 2014 14:16:42 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
>=20
> > Hi Thierry,
> >=20
> > On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> > > On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
> > > > On Mon, 21 Jul 2014 11:32:55 +0200 Laurent Pinchart wrote:
> > > >> On Monday 21 July 2014 11:24:38 Boris BREZILLON wrote:
> > > >>> On Mon, 21 Jul 2014 10:59:12 +0200 Thierry Reding wrote:
> > > >>>> On Fri, Jul 18, 2014 at 05:43:34PM +0200, Boris BREZILLON wrote:
> > > >>>> [...]
> > > >>>>=20
> > > >>>>>>>>>> + - atmel,panel: Should contain a phandle with 2 parameter=
s.
> > > >>>>>>>>>> +   The first cell is a phandle to a DRM panel device
> > > >>>>>>>>>> +   The second cell encodes the RGB mode, which can take t=
he
> > > >>>>>>>>>> following values:
> > > >>>>>>>>>> +   * 0: RGB444
> > > >>>>>>>>>> +   * 1: RGB565
> > > >>>>>>>>>> +   * 2: RGB666
> > > >>>>>>>>>> +   * 3: RGB888
> > > >>>>>>>>>=20
> > > >>>>>>>>> These are properties of the panel and should be obtained fr=
om
> > > >>>>>>>>> the panel directly rather than an additional cell in this
> > > >>>>>>>>> specifier.
> > > >>>>>>>>=20
> > > >>>>>>>> Okay.
> > > >>>>>>>> What's the preferred way of doing this ?
> > > >>>>>>>> What about defining an rgb-mode property in the panel node.
> > > >>>>>>>=20
> > > >>>>>>> There's .bpc in struct drm_display_info, I suspect that it co=
uld
> > > >>>>>>> be used for this. Alternatively, maybe we could extend the li=
st
> > > >>>>>>> of color formats that go into drm_display_info.color_formats?
> > > >>>>>>> RGB444 is already covered.
> > > >>>>>=20
> > > >>>>> I forgot to ask about bpc meaning. If, as I think, it means "bi=
ts
> > > >>>>> per color" then it cannot be used to encode RGB565 where green
> > > >>>>> color is encoded on 6 bits and red and blue are encoded on 5 bi=
ts.
> > > >>>>=20
> > > >>>> Yes, I agree that bps is not a good fit for what you need here.
> > > >>>=20
> > > >>> Okay, then I think we can replace bpc and color_formats by a
> > > >>> bus_formats table containing all supported formats, and use an en=
um
> > > >>> (something similar to v4l2_mbus_pixelcode defined in v4l2-mediabu=
s.h
> > > >>> [1]) to list the available formats.
> > > >>>=20
> > > >>> As this implies quite a few changes in crtc core and some drm dri=
vers
> > > >>> (nouveau, i915 and radeon), I'd like to be sure this is what both=
 of
> > > >>> you had in mind.
> > > >>=20
> > > >> I think it is, but just to make sure I understand you correctly, c=
ould
> > > >> you just show how the drm_display_info structure would look like ?
> > > >=20
> > > > The new drm_display_info structure should look like this [2] (except
> > > > that color_formats and bpc have not be removed yet), and [1] is just
> > > > here to show how the video_bus_format enum would look like.
> > > >=20
> > > > [1] http://code.bulix.org/rfd0yx-86557
> > > > [2] http://code.bulix.org/7n03b4-86556
> > >=20
> > > Quoting from your paste:
> > >=20
> > > 	+   const enum video_bus_format *bus_formats;
> > > 	+   int nbus_formats;
> > >=20
> > > Do we really need more than one?
> >=20
> > We do if we want to replace the color_formats and bpc fields.
> >=20
>=20
> Yes, that's what I was about to answer :-).

Maybe we don't need to replace color_formats and bpc field immediately.
That could be done in a follow-up patch.

Thierry

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzQ26AAoJEN0jrNd/PrOhXpwP/1jw6XI6V+3qM3p3tiungob8
C19a/s9lrO3kteMAy5wG5WmV5/WoLUrqOY4hTqJPHUgzck0x8oOI3YG7/pbseP9u
Yg44Ohd4Xz4WTU9h/ZoI4P521facXzfMVhAgN/SfJl+t/2i7aqL/LZCn7qX9MMFz
UK/guAGRfNgOLhJ4moMZEcs8VE1++XTVGUL3vVBNBMjp0YCavnPxvhhaxfZVttIm
V6FUxCQ4M6ou0mLyU9QBEp5UiBC9elckcBM38p+OkN5X0IoY59e7hBL5QpUqzSKl
PeRFXCdvG6JsKzcyzOOSxAlhsJLOcciuvVtLz38aN1MXTb6p31JlS8XZUVpNP6K9
GED6dG0SPQ1EAiuM2eQ7xzB0b69cyfuWXQNT4tIDrwPM+KPt0TTwCYq7odNiMXD5
3ICmpH3fOYS3Od1ux0eXLV4+nUvnSX8KmfD1GlBeXqne9qwP/ipgoWPvKFRu5yvI
Ov0Rvh6eiqZwb09MSLmb9o0MUoqWnINy8SvxyKhd+OQCwsFTtYzqYO49KE66RhYy
2coZ0W00bGnDLJmt0vi38hwdP4gd9LaaB0czxb7F6Tcvj429Ebf9XK7nET32RdvG
dfUALqRAx4NlPPtPsWFab2hGWOT3PH/xI7D8Wp5009n7JCT2jS6rD5Pk3YoDncA7
zSjXvY2GBTd9tnvJJuId
=xLJw
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--

--===============1413851757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1413851757==--
