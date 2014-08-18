From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
Date: Mon, 18 Aug 2014 10:31:35 +0200
Message-ID: <20140818083134.GB31171@ulmo>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: linux-pwm@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, rdunlap@infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2014 at 11:32:32AM +0800, Xiubo Li wrote:
>=20
> This is depended on the following patches, which has been applied by
> Mark into his Regmap-Tree:
> https://lkml.org/lkml/2014/7/15/6
> https://lkml.org/lkml/2014/7/15/5
> https://lkml.org/lkml/2014/7/15/7

This doesn't seem to have any build dependencies on the above patches.
So with only this applied to the PWM tree at worst the registers will be
accessed in the wrong endianess and the PWM won't work as expected. Does
that matter? Or should I request a stable branch from Mark to pull into
the PWM tree so that this doesn't happen?

In linux-next things should be fine since both branches will be merged.
I guess there could still be an issue depending on the order in which
Linus merges the trees for 3.18, in which case there could be a brief
period where Linus' tree runtime-breaks on platforms requiring this. But
I'm not sure if that's really an issue.

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8bnmAAoJEN0jrNd/PrOhztgQAJsTW6cgDo9I4w067RqFr1Cq
Jk1/jiPbUhQ+ZtGA4/+yQ+eRFknWUxLGAsRkATg8RO8StDUHK5ZwH9UcWdObrays
JDK9jcCiAfHNOoS4kABzYPx2ZzrrC0SrWC7KaiSXxyUMKP6D2skGavr+82SLlIGh
RFk+EOjpd7PWKAfhSI3r7pBuOPe0YFeHSnwhBpUR8dikn+d3103XcnqgWCeVl85t
RTgJmTEBvlpowbIA/6q+3GDBqCOTE/NvxMXveDBIeAUHdXrfbWj2J7OA9F5hPXBe
BEPyekUIxv/SslmaNkmjElLx6HArxYX2kXFDJyiayG4IwVFyosrfVwtf8Zehy00r
eisTeEFddxomhi4oxhiKuWlpBz30MNUj7GG+TtDNy1ssv+a23B446aNwa5REDrtQ
lkyT1/ZRpX+RMd774Tfol569MOrNweFPQEYOk1EllfJUqPAUn7icYNkrPwRjJXN8
kno77PW7sJVyuhkRZswynBkH3QZFF6jmWqcbRNMaJhTb2lNnGTpJnGPFobWTheuH
sASK/jq4ll44nqLv0T/uG0uMSvbGQvRWJ0zCMK9JRFQOcitw3Ce5JPiytTfpuqZX
ri5GVmL5N08FHPky8JmVIiz2ZR5oPz98+X6xKUhXFmy6d4myR1blViaOoOKro0Y7
8uKdKOzNoeAhrtOZVOZT
=mQdq
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
