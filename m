From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 15:22:05 +0200
Message-ID: <2695740.osZpCPIB8S@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0480747321=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721125522.GE15238@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============0480747321==
Content-Type: multipart/signed; boundary="nextPart1692194.q5RyYzooKS"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1692194.q5RyYzooKS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> >> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> >>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:

[snip]

> >>>> The new drm_display_info structure should look like this [2] (ex=
cept
> >>>> that color_formats and bpc have not be removed yet), and [1] is =
just
> >>>> here to show how the video_bus_format enum would look like.
> >>>>=20
> >>>> [1] http://code.bulix.org/rfd0yx-86557
> >>>> [2] http://code.bulix.org/7n03b4-86556
> >>>=20
> >>> Quoting from your paste:
> >>> =09+   const enum video_bus_format *bus_formats;
> >>> =09+   int nbus_formats;
> >>>=20
> >>> Do we really need more than one?
> >>=20
> >> We do if we want to replace the color_formats and bpc fields.
> >=20
> > Yes, that's what I was about to answer :-).
>=20
> Maybe we don't need to replace color_formats and bpc field immediatel=
y.
> That could be done in a follow-up patch.

We don't need to replace them right now, but we should at least agree o=
n how=20
to replace them. Introducing a new field that would need to be replaced=
 in the=20
near future when removing color_formats and bpc would be a waste of tim=
e.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1692194.q5RyYzooKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTzRP9AAoJEIkPb2GL7hl1CRwIAKsndmFK9LfGyqybt0xELJL3
0hFgaQ217OVUnQAZIdRsV9ggUykJb8QDkkQ8PB9Wj3ozpTY2GawkPTxTkeEwnhgx
mTR06286JIpstXd3sXHnHsnxaDZrTqCKShTmp2o3Tjm+5qpuAuS7bghPu5SVdwJG
NLjnx/77UwBvPfwQ1F6cZne1Qb5GgbckBqYdXeJDcEOHGxH0iJJd/M34LwTjL/AG
DXONP/ZINX7S/yRLX71kAG/btPNanEc8to70gLRdpkke+M55bsuU+AhDa28uhkpu
scW+SWJ5ckflZVLMZZ/M6Il+Ub5w39kyx8v//qit4DPeyjyx0FHk/CuuDdfNFWo=
=BXe8
-----END PGP SIGNATURE-----

--nextPart1692194.q5RyYzooKS--


--===============0480747321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0480747321==--
