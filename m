From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 15:30:35 +0200
Message-ID: <20140721133034.GI15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo>
 <2695740.osZpCPIB8S@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1865837584=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2695740.osZpCPIB8S@avalon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============1865837584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 03:22:05PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > > On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> > >> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> > >>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:
>=20
> [snip]
>=20
> > >>>> The new drm_display_info structure should look like this [2] (exce=
pt
> > >>>> that color_formats and bpc have not be removed yet), and [1] is ju=
st
> > >>>> here to show how the video_bus_format enum would look like.
> > >>>>=20
> > >>>> [1] http://code.bulix.org/rfd0yx-86557
> > >>>> [2] http://code.bulix.org/7n03b4-86556
> > >>>=20
> > >>> Quoting from your paste:
> > >>> 	+   const enum video_bus_format *bus_formats;
> > >>> 	+   int nbus_formats;
> > >>>=20
> > >>> Do we really need more than one?
> > >>=20
> > >> We do if we want to replace the color_formats and bpc fields.
> > >=20
> > > Yes, that's what I was about to answer :-).
> >=20
> > Maybe we don't need to replace color_formats and bpc field immediately.
> > That could be done in a follow-up patch.
>=20
> We don't need to replace them right now, but we should at least agree on =
how=20
> to replace them. Introducing a new field that would need to be replaced i=
n the=20
> near future when removing color_formats and bpc would be a waste of time.

Sure. One of the problems I see with replacing color_formats and bpc
with the above is that some of the bits within color_formats are set
when the EDID is parsed. That implies that if they are replaced with
an array of formats, the array would need to be reallocated during EDID
parsing. That sounds like ugliness.

But if you can find a nice way to make it work that'd be great.

Thierry

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzRX6AAoJEN0jrNd/PrOh7v8QAJJjO7YJ0RyJgsI8PQpgw+XJ
u0xLmqBoLVSgpktBwqpzjQqbYCNa1SGXMSLdb3QGGWZtu5+9LuUifKnulMk9wxKr
W2EXFfIsNtVJDmt7NpUoiIY/dAHuoK9AFvwDCID0sFwxe0xjl+xM7fSZ8t/4v0eT
dt7IvApnMa3XtxjPrzCvlViY7fKYXVMyMKE2MDA0XaOqgAEolTZ1DyivLBD/ewkV
sbtSpbtPhRhQ35uaJ8RNSFKB8arBBLnV4Q+0I3+gYyQZkXXjisKDN4P8yTam5M84
DQhv25jfBiMBn3P+QSIowJkWBqrKqT/qELZEPmUIKLSMzPgxPRBpNi8dcQVZY97n
9eCTZgg3plHQhlu3J9Abhh9KErsB518TAYo3N7uXYCD3idcIUx2NbwPnl7RM5CvA
vkM0oYtRZ7MrwwCodEyLcygd7iHnqYey7gOB3r2e2pn6t1Re9mXDPV6E2vvg6cBs
kOdfwJz95dFP2PSLYylstrlxvCzrvnA/GvpQZQ/xD0ocwly+TjcCP8yck4ztySdu
prGgG46yQT0oE1yFO3go9QnbV/6XFzubnDOpqr85YsdvaM/q9G2PM8sWMFUMP8Ai
MTHenniHmHRSYCulZ0hNhhVCoSp0UQDgI/Vpsh0Yx+kzW6u0RmBXgJuPzJMS2wJs
estYklSyYU89Pq32WeqV
=jAI0
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--

--===============1865837584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1865837584==--
