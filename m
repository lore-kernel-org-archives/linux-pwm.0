From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: lpss: Add support for multiple PWMs
Date: Fri, 6 Nov 2015 14:29:53 +0100
Message-ID: <20151106132953.GA31797@ulmo>
References: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 04:53:05PM +0300, Mika Westerberg wrote:
> New Intel SoCs such as Broxton will have four PWMs per PCI (or ACPI)
> device. Each PWM has 1k of register space allocated from the parent devic=
e.
> Add support for this.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 48 +++++++++++++++++++++++++++-----------------=
----
>  drivers/pwm/pwm-lpss.h |  1 +
>  2 files changed, 28 insertions(+), 21 deletions(-)

Applied all three patches, with a minor cleanup, see below.

> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index aa041bb1b67d..ef2419f47c57 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -20,6 +20,7 @@ struct pwm_lpss_chip;
> =20
>  struct pwm_lpss_boardinfo {
>  	unsigned long clk_rate;
> +	size_t npwm;
>  };

I changed the type of npwm to unsigned int to match the definition of
the pwm_chip.npwm field.

Thanks,
Thierry

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPKtOAAoJEN0jrNd/PrOhTdUP/1NgqpiWYAkBujbTDwzNXKnB
WvNzq48T1dqB6VBhoW60E9QVJH2bB78S8nyJxNXdDIL6sas8e8htq73aXjGEsZ3L
IpHdf8v+AtTft59uEdYIl4LmaxsTfvNXmSjpAr6vL2cHH+fSSNgwB9DaufUPnIX3
D/DL7k+yyhosu0YD7EIDAug7yMcGPCvS/Nc3c/3PRkKx1GKhaOyyfT0mr8ZpNH+3
roZOW0dfX/Zxul1hCDBw4FeusDPnNgXKNfUhBXjDPTWtKxZuKkZRVhJFStc2eOFA
hmH3wQWQISDHPtBB56ogDMU0cDf0npjjX39F7fB2Lkd+MZBn8xw7dB2uLFLpkPod
v1qDKKAHRRGopl1MnwnPJL/jYQXFZmCGI0uUnygf1w62S7DIV3emoeyoSRYDhZo4
i/qb6r5bkRMKj92JUd8YbxKzstPnqQnv8F4nu3ypPaY2Op/FQNWan9Drvfy3qMVU
1MQAMd2Rm4qlYlLTBKn8grJAVjcXG2oYhAoIr/pkU0QkqTHzRBZgtiDGn5qOEOdF
jWH27mRQSkFjOtY2kQWSDv9LjBkbKeJAj3C6EQsc84QSkLPlEaJHfd3LZ5/xcTFN
Zj9YHr69Rpjy9LCy6kKMPzDE8O/iwhv3l4SYdN9NwysNbKsOmqeSliyILzlAkktv
TFZpYIqXFE45ZrfSBzyC
=qTH8
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
