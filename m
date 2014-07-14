From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 14 Jul 2014 12:18:08 +0200
Message-ID: <20140714101807.GC9870@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1584022.nQ4HpIUW7J@avalon> <20140710145626.48cb956f@bbrezillon>
 <33456066.4Q4p6nxKdU@avalon> <20140711140025.62873695@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828485284=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140711140025.62873695@bbrezillon>
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


--===============0828485284==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 02:00:25PM +0200, Boris BREZILLON wrote:
> On Fri, 11 Jul 2014 12:37:46 +0200 Laurent Pinchart <laurent.pinchart@ide=
asonboard.com> wrote:
> > On Thursday 10 July 2014 14:56:26 Boris BREZILLON wrote:
[...]
> > > BTW, is there any reason for not defining an RGB connector type (I'm
> > > currently defining HLCDC connector as an LVDS connector) ?
> >=20
> > Not that I know of. The DRM API has been developed before display on em=
bedded=20
> > systems became such a hot topic. If we had to redo it today, panels mig=
ht be=20
> > exposed to userspace as such, with a connector. We have to live with th=
e past,=20
> > so the connector will stay, but adding a new RGB connector type could m=
ake=20
> > sense (although we might need a different name, in a way the VGA and LV=
DS=20
> > connectors also carry RGB signals).
>=20
> I had the same concern: I didn't find how this kind of connectors
> was named (most of the time they're just referenced as RGB) :-).
> What about RAW_RGB ?

Are there even panels that take raw RGB as input? In all cases I've seen
(which admittedly may not be all that many) there's always a transparent
RGB/LVDS bridge, so the "connector" is in fact LVDS, not RGB, even if
the display controller outputs RGB directly.

Thierry

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw65fAAoJEN0jrNd/PrOh//kP/2f2E2OBjxdIuUMOHJTj6Z5Z
myc6BM/F/msODPNaspYu+JTx9onqO7UIYnwYlpgKENPRQAd3wx+0FY/3zVI2gXRZ
nv3x7BhCV6w+/8l52thzr2sLOHieodaQTHA10sEcuRMJ8OuwLNhn5nkpKOCCsrll
x19H3hHIKzJkYezITijoC4CdL9C7KorsuOni125g44LYhabZt7uDSiJJDW6VHumP
J62i1WSbnNExV5wJcLpO2irZghjARyfTTJJiQWnW7x6ia4MfJORTEV+6tmCKBR75
9wV3ophrNW1fAMmtvIZidr4jHgcQQc6FtjokUB3xG82hepRlqDuz4QTDqDMWd/6K
I5SynwHPynTrmv/NfJhnq+1f94aLtQHdd2yNriYEFn7EjcKocTRDSpFJEI/MSVqZ
0FnBLq+3SHU7g9mxvOJ/eanU8JMLqnWqVY480OadU+GFe/4j8JQ+fEBUzL3wNH1l
Pz4wsIZV/6LcBA67hPBAJSjae4vBE6Wb59xUgnZgAPlsevhcUT/PJ/h+HClriEjH
vLgPqmD1CLlbxPxEFQggwVdRZHL32u2l2cQYfGQa6sVjwblIHl774jxiLrnAJnKl
Kz6p2uZt1m+Rsx97AGPz47L0OVh4f2Ej1x2c/3zZZEAc3ZZTgGcv+3r1/btusv31
+bRpYKy6l8wV5tcsiSiM
=A6f8
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

--===============0828485284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0828485284==--
