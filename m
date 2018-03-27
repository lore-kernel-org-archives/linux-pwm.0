From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
Date: Wed, 28 Mar 2018 00:30:48 +0200
Message-ID: <20180327223047.GG28163@mithrandir>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
 <20180302105719.GC27178@ulmo>
 <1520030090.8089.186.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520030090.8089.186.camel@mtkswgap22>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 06:34:50AM +0800, Sean Wang wrote:
> On Fri, 2018-03-02 at 11:57 +0100, Thierry Reding wrote:
> > On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > >=20
> > > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > > programming on PWM hardware causes waveform cannot be output as expec=
ted.
> > > Thus, the patch adds the extra condition for fixing up the weird case=
 to
> > > let PWM4 or PWM5 able to work on MT7623.
> > >=20
> > > v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> > > v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Zhi Mao <zhi.mao@mediatek.com>
> > > Cc: John Crispin <john@phrozen.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xhcACgkQ3SOs138+
s6GemRAAven23G0YiLEVbk8S+JKm4WpzNzax/Nsk3xja50+dVlf3+VoeRa/PCW/e
QguUdC8q9QyujEC/XzNJaaqxIa5T43kOcTePVuwrEHq54+2IFoNSDWi+OuUsCZyu
ujjK0B3w1Q67ExSqUw9EbeF6dnJf4EZSZCo9iej4TCY8I/bMTcwOaope6itRyKn0
Y6dp6v5Bpx4Frf4QEH9QObiCJmwsdCgKTNsoLdowqWYrXic3jXA9V1GQPBGXSCCJ
s8k8bH8vBiGR8FVqPU+DE6NYMb/FjvAxHXMNaFSPhGyMyZpTcPloA0Aq9JTLWfhW
0V7WrWI9oA0yomKC3nuNCOBFtByniUlrRIGncWLFrmU6vo/H4Th87TQzeDUc7ue3
9pHcvWfW3Py9LgR0xDffTw1FNbeAAiVsedahQf2WfLR1ecR5ys4RjrHOoH7Ajjw0
BnNPLxJN4jYyadlG+qtRTxnlExWEfVMyGvbmhaBtnpgqBTsrWL2T94QYWFKWc3AA
9JOa4iBQ18D+IWWJM06et+ftMkWzkENL5mIPiQ1RomCIiAOFL6+EhYHx9t8kD+0o
UR+LPVdYwmh+Yfj8uMNvghflJi4iIAijZ+0sA3M8SnhLyAmDPXWarissJ3Ei+5aG
++a6F7qDY1K9XSwTQICbWhS2DYsxx+DBvVGIcjy6O9xx3rLc+0U=
=aYXi
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
