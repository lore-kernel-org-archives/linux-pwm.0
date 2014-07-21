From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 22 Jul 2014 00:04:11 +0200
Message-ID: <20140721220409.GF12076@mithrandir>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721135410.GA13770@ulmo> <20140721162136.286f5b62@bbrezillon>
 <6062556.5zQdTSJFua@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0577670375=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <6062556.5zQdTSJFua@avalon>
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


--===============0577670375==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 08:30:31PM +0200, Laurent Pinchart wrote:
> Hi Boris and Thierry,
>=20
> On Monday 21 July 2014 16:21:36 Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 15:54:12 +0200 Thierry Reding wrote:
> > > On Mon, Jul 21, 2014 at 03:47:52PM +0200, Laurent Pinchart wrote:
> > >> On Monday 21 July 2014 15:43:13 Boris BREZILLON wrote:
> > >>> On Mon, 21 Jul 2014 15:30:35 +0200 Thierry Reding wrote:
> > >>>> On Mon, Jul 21, 2014 at 03:22:05PM +0200, Laurent Pinchart wrote:
> > >>>>> On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> > >>>>>> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > >>>>>>> On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> > >>>>>>>> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
>=20
> [snip]
>=20
> > >>>>>>>>> Quoting from your paste:
> > >>>>>>>>> 	+   const enum video_bus_format *bus_formats;
> > >>>>>>>>> 	+   int nbus_formats;
> > >>>>>>>>>=20
> > >>>>>>>>> Do we really need more than one?
> > >>>>>>>>=20
> > >>>>>>>> We do if we want to replace the color_formats and bpc fields.
> > >>>>>>>=20
> > >>>>>>> Yes, that's what I was about to answer :-).
> > >>>>>>=20
> > >>>>>> Maybe we don't need to replace color_formats and bpc field
> > >>>>>> immediately. That could be done in a follow-up patch.
> > >>>>>=20
> > >>>>> We don't need to replace them right now, but we should at least
> > >>>>> agree on how to replace them. Introducing a new field that would
> > >>>>> need to be replaced in the near future when removing color_formats
> > >>>>> and bpc would be a waste of time.
> > >>>>=20
> > >>>> Sure. One of the problems I see with replacing color_formats and b=
pc
> > >>>> with the above is that some of the bits within color_formats are s=
et
> > >>>> when the EDID is parsed. That implies that if they are replaced wi=
th
> > >>>> an array of formats, the array would need to be reallocated during
> > >>>> EDID parsing. That sounds like ugliness.
> > >>>>=20
> > >>>> But if you can find a nice way to make it work that'd be great.
> > >>>=20
> > >>> How about using a list instead of an array ?
> > >>> This way we can add elements to this list when parsing the EDID.
> > >>>=20
> > >>> Or we can just define a maximum size for the bus_formats array when
> > >>> retrieving this info from EDID. If I'm correct we have at most 18 b=
us
> > >>>=20
> > >>> formats:
> > >>>  - 3 color formats:
> > >>>    * RGB 4:4:4
> > >>>    * YCbCr 4:4:4
> > >>>    * YCbCr 4:4:2
> > >>>  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color
> > >>=20
> > >> bpc isn't a bitmask, so EDID supports up to three formats only.
> > >>=20
> > >> The color_formats field is computed in the drm_add_display_info()
> > >> function. You could easily turn it into a local variable and allocate
> > >> and fill the formats array at the end of the function.
> > >=20
> > > But you also need to be careful to keep whatever formats the driver m=
ight
> > > have set explicitly.
>=20
> Do we have drivers that explicitly add formats to the formats parsed from=
 EDID=20
> data ? If so, what's the use case ?

Drivers could specifically add them if there's no EDID or if the EDID
is known to be broken. If the former this is probably irrelevant. In the
latter maybe a better option would be to ignore the EDID-probed ones
rather than use the union of those provided by the driver and EDID.

Thierry

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTzY5ZAAoJEN0jrNd/PrOhMisP/26n5BeZGFNyryyOXosnLmYX
KtQrp9JXk7cHNJ2dlyVyzp/bKB61JOQKo5efKwcLCs5PLRg8ioENot3XDQXixTt2
Sj0VhDDj1K+INvK/jH815fSFXtbsOawipXyyhuZeLD5OOPhts43iKdcQ3izCBe2K
NpitElZaRrMfyY6M2+r5BcFtgsiNtY9saqCfFzbnLZfTLobCYEEe5zUdWsZ3zJDJ
rmYGrG3uts6c6WbDsqk2zkG39e+T6Hdk1kifaWczAdwt2g916gkBQN0hYzGcQuMp
ao/XkTl0gI8MDdHUZeBn1NZWste08AjhG6UvVrtizYJmLoP0c7cuWWOf/F5G1kOy
Nyf2ZeF4JVrd9PxzXuOFp971skCNjv0pZyjOL2FerhQjUzmcfssoAT3RDJQ8haIq
thECyXP5M+cQg6TWf8mwtuyI9C8CISViB22bVkO+E34r1AUYeHRfJ7rQo9cCd77f
nnDrqSofcQXDWMkb62Qo/EWayFlusC5R9/XoP36eI0zSy8MS68+v2zK4mLxnxLAS
hYElbVeOC/A8v27Qc5gMJRx5WnRCJCFlu/CWQ0lzzqZB5VaAVQGOd8x9aWmPjUQ4
kP16St5kOn82M9kxaGGGEWY0FJjIyRx3YkGnCHscL0BR1+Ljt5En09iDdFWcmiXI
mQTm5CyvZY1kjL/DTiGa
=milW
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--

--===============0577670375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0577670375==--
