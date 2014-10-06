From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 04/11] pwm: add DT bindings documentation for
 atmel-hlcdc-pwm driver
Date: Mon, 6 Oct 2014 15:26:57 +0200
Message-ID: <20141006132656.GD26921@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-5-git-send-email-boris.brezillon@free-electrons.com>
 <20141006101350.GD25202@ulmo> <20141006145912.1e448507@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2117803787=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006145912.1e448507@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--===============2117803787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 02:59:12PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 12:13:51 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Oct 01, 2014 at 04:53:01PM +0200, Boris Brezillon wrote:
> > > From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > >=20
> > > The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n1=
2,
> > > at91sam9x5 family or sama5d3 family) provide a PWM device.
> > >=20
> > > The DT bindings used for this PWM device is following the default 3 c=
ells
> > > bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 55 ++++++++++++=
++++++++++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc=
-pwm.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.tx=
t b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > > new file mode 100644
> > > index 0000000..86ad3e2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > > @@ -0,0 +1,55 @@
> > > +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM dri=
ver
> > > +
> > > +The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> > > +See ../mfd/atmel-hlcdc.txt for more details.
> > > +
> > > +Required properties:
> > > + - compatible: value should be one of the following:
> > > +   "atmel,hlcdc-pwm"
> > > + - pinctr-names: the pin control state names. Should contain "defaul=
t".
> > > + - pinctrl-0: should contain the pinctrl states described by pinctrl
> > > +   default.
> > > + - #pwm-cells: should be set to 3. This PWM chip use the default 3 c=
ells
> > > +   bindings defined in Documentation/devicetree/bindings/pwm/pwm.txt.
> > > +   The first cell encodes the PWM id (0 is the only acceptable value=
 here,
> > > +   because the chip only provide one PWM).
> > > +   The second cell encodes the PWM period in nanoseconds.
> > > +   The third cell encodes the PWM flags (the only supported flag is
> > > +   PWM_POLARITY_INVERTED)
> >=20
> > Given that this already refers to the default 3 cells binding it doesn't
> > need to repeat part of the contents of pwm.txt.
> >=20
> > With that fixed and assuming you'd like this to be merged via the same
> > tree that the DRM and or MFD driver is, this patch:
> >=20
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> >=20
> > If you'd prefer this to go through the PWM tree just let me know.
>=20
> Yes I'd prefer this solution, but shouldn't we wait for Lee to take the
> first two patches in his tree ?

Yes we should. Dependencies could get a little messy to deal with.
Perhaps if it isn't too late yet, Lee could take this into the MFD tree
for 3.18 and then we can take the PWM and DRM patches for 3.19. Another
possibility would be to take the MFD patches into a tree and provide a
stable branch for David and me to pull into our trees.

Thierry

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMpigAAoJEN0jrNd/PrOhBtsP/ArRipMlERaB9JBzU/DmxitO
BMMIVA5XJKqcExxBVVf8ZTe7vj5BNHcOn59ejD+m5wbRYDZI+8E10MrfRvk+aRy+
XSufkW5P2nDd+LB9fRhURhBbsMe3cm6ftFMvXf5jaoQZMvPVdQUYY8cSBMdmqahd
CxSMH/qRwrBSrqj2ny1Jzg5LtovSeldQEPYktMUIr/oEGZ0icAtx4fwcz6Ox8fTs
Tlb/Y9b98aGLSfnAq42qM+HqHKDQrOk5P+xPWgY5Ag6fv6gkzwrQoKUKwfzbvplg
o1OvRfITAFbZCc+Bm8RCm20ECngRur28UX5b4seR4yqYDocOx9A5o+EoFxQuqY/H
kU42JomnTvd7wDbStTbxWPoNBqz2nMPiQ/6gx+FKZu4Q/2FuLiN7fPj5eUD3C+i7
Vj6NScn+OafY10x330xqsgfW6rDYh9GlnRsBlt90tLFk/9Zva/URfsqFM1L3AIwB
f13MW1QNFhKXOGj5z5Ui8AiyPb3V2SE+Rtaaipi30N+Q63sBUVm3Q6lUlo6mPepP
FLOls6lQVHVIK7YyW4ycqvguLIZE6gu5D5rnr+J3Yj9IN7qXaxvCC8Nb579SN7L5
r1GKyY0R3Q+tvT0c2vv7fOVkJ6Tg+QzIiTdlWCNj4LqZZee8tgCvo1dTu8OLiDSm
WsfuXLW/Zd0xskNJdz9r
=daLB
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

--===============2117803787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============2117803787==--
