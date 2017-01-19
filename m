From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 3/8] PWM: add pwm-stm32 DT bindings
Date: Thu, 19 Jan 2017 10:04:27 +0100
Message-ID: <20170119090427.GA28834@ulmo.ba.sec>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-4-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8030120340640047897=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484749251-14445-4-git-send-email-benjamin.gaignard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, gerald.baeza@st.com, fabrice.gasnier@st.com, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, jic23@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org


--===============8030120340640047897==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 03:20:46PM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
>=20
> version 8:
> - reword st,breakinput description.
>=20
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
>=20
> version 2:
> - use parameters instead of compatible of handle the hardware configurati=
on
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

One last nit: please use "dt-bindings: pwm:" as prefix for the patch
subject. So it would read something like this:

	dt-bindings: pwm: Add STM32 bindings

or similar. That's the style that's been used for a while now. I'd have
fixed that up myself, but since Lee plans to take this through the MFD
tree I'd like to see that fixed up before it gets applied.

With the above:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliAgRgACgkQ3SOs138+
s6GVjA/9FoqkIRnh7HP2iHJEaW6DrgyHcdaBexg1gPl2KV0p3QZs2p0qahOIwOJ8
APfU/lrCKkmoSmWrJIfXLxYGHb6Wqt8c39zLBY9IqWtcVmg+xRnRBYEVahK3RDSD
OHw8NEVYIUfQyMFJa2c8MgAdIZoo+qHDmE1Op5bHGdM6EXMTjcGltQmu6dSibNNs
ZOv2V2cZ9I7TAok9aANsie4nfAzsfmkazHgWf770ohg3u91tjyekImubkvk3N0Px
Y9K8iNoDWYj72r5cpDX9y4xEte9/CIexqzP/xO1TX7ebyilFGHIXxV0QMxyoOpPa
LtaxwZawYQgfV51h01bm2lmHXAcSZpFZt6R7cOnV6XmXasrtKAmiv6GmKqI1PZze
BSiYIAPn5BB0eWUnlRLFC3RagP6dmhYijA83Kmqd8nRXQ8xSdEiqTkdP1eicqjuC
qlLZL+VHYiZPUtQhiRtRTUQxAYNn5EH0xt6hFRRU8CoUHusLg5pNZ5fgJZ2Lmhcr
bWjUtdLyRX0wF/EJPGmZSq6PKwAs5p493iniOfs57PGPJ+VVh1kqkXzxNcNTOdzS
28incWdTztLZdvUZAN3brp5mUl8RbLkk5L/dWV5hpXJpnr1FsNYGr/RYSLL1qt2Q
89kuQjpHXKet1xPlpEo3Jw4W/vqaSwEgq2BIe+rBO3Lb56NOTeo=
=nS5i
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--


--===============8030120340640047897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8030120340640047897==--
