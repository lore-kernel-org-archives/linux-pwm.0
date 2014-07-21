From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 22 Jul 2014 00:17:17 +0200
Message-ID: <20140721221715.GG12076@mithrandir>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo>
 <2695740.osZpCPIB8S@avalon> <20140721133034.GI15238@ulmo>
 <20140721154313.1de8bf6f@bbrezillon>
 <20140721170630.GG21766@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1737163214=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721170630.GG21766@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============1737163214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 06:06:30PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 21, 2014 at 03:43:13PM +0200, Boris BREZILLON wrote:
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
> This starts to worry me.  What are we trying to do here - are we trying
> to encode the connection between the CRTC and the encoder, the encoder
> and the connector, or the connector and the device?

This is about the bus format of the panel device. That would make it the
latter.

> The encoder to connector and connector to device is mostly a function of
> the interface spec itself (for example, many HDMI encoders take either a
> RGB or YUV input and can convert it to the HDMI specified colourspaces for
> transmission over the connector.)

The discussion here started because we currently have no way to store
information about the interface for raw RGB. That means currently all
drivers need to hardcode assumptions about the mode. The idea was to
make this information available via a field in drm_display_info so that
drivers could reconfigure depending on what the attached panel expects.

This doesn't only apply to panels, though, the issue is the same when a
bridge (RGB/LVDS for example) is connected to the encoder.

> If you want to do encoder to connector, what about VGA or some other
> analogue signalling such as TV composite?  It's easy to take this too
> far...
>=20
> Surely the only one which matters is the CRTC to the encoder - that's
> certainly true of all the setups I've come across so far.  As for that
> interface, CRTCs I've seen can produce a /wide/ range of different
> representations.
>=20
> Some CRTCs (eg, AMBA CLCD) produce R, G, B signals scrunched down on to
> the LSB bits of a LCD data bus (so RGB888 uses 24 bits, RGB444 would
> use the LSB 12 bits of those 24 - rather than outputting the R4 bits on
> a subset of the R8 bits.)
>=20
> What about RGB565 - where you have differing number of bits for the
> green channel from red/blue?
>=20
> Then you have red/blue colour swapping at the CRTC (and similar for YUV)
> such as on Dove / Armada.
>=20
> Then there are some encoders have the ability to almost arbitarily map
> their input pins according to whatever you choose (eg, TDA998x).
>=20
> This problem isn't as quite as simple as "this is what EDID gives us"
> and "these are the number of bits representing a colour".

I think what we need is a way to pass information from whatever device
is behind the encoder (be it a bridge or a panel) to the encoder. And
likely we'll need a similar (or the same) way to pass that information
=66rom bridge to bridge or from bridge to panel.

That way the encoder can ask the bridge (or panel) about the format it
requires and reconfigure itself accordingly. This should be able to work
with an arbitrary bridge -> [bridge... ->] panel chain where each
element in the chain can reconfigure depending on what the next element
requires (or fail if it can't work, which should really never happen).

Thierry

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTzZFrAAoJEN0jrNd/PrOhPpIP/1l5YvcDMse9OqXNqYr7IPBr
cx0Noh7j943idlPecaCufKAwXB2bZntP3AiPGU7DIfkft7UhsRx7SMQWAGhG6ugA
KDKoOz/TC5LblKDDDqkVAVQIq6e04h/4YKEIdTKZ16WM3Jb3pa8SmKlCeaLiGt11
YRTrlVN3mqdf5d/4ps3mqn6Fp1AWfEFw/AohaQR0pUA7vjLzVIgqlJ+5ki45jQJt
pNi7+jnJ1iRJzFPl1Y5tcJcg3EN4gmnA06S4aX2YnvSEbWKG7PXNvjTOnYY9zika
rdUim8K+Tm3IkHN1FtalwfgOfCqcFiqipahNeZNMudsIb+q1xoD1mamyAZqSPsQM
Rh8LDk3SyQCCUOBSlbH25hLuX2kEcVqaMKH+LuRXQU3NoIHxXhFc78HhzdohQ/YQ
160qh/m6UE04W+OPa7aNtyBfjt57Fw/8psNBEK+fvPLCV406yU0VTS0jnx3OI1k8
xs1tSqQXJNanzaOm+Os4V4JJcQelAkqpfdyVQjU+MxiBJrlIyD1FG93vWVE21vLB
MwIEHusgon2ePfRpeZT2xWGwNUizuiEhIR6yLYSzHrVB+AEVjXjbZOfFqX7pL3LY
YxwDRnt1d7gHfO+dQH5yHdDEAKvP6YTHnJJLlR9sAC9B6uGYcV1tfmj7dMyZfBO8
sqxsBYvgLrvyx4s3R0D0
=UNwp
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--

--===============1737163214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1737163214==--
