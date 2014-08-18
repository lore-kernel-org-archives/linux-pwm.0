From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv3 2/3] pwm: ftm-pwm: Convert to direct regmap API usage.
Date: Mon, 18 Aug 2014 10:36:49 +0200
Message-ID: <20140818083648.GC31171@ulmo>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <1408332755-35102-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408332755-35102-3-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: linux-pwm@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, rdunlap@infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 11:32:34AM +0800, Xiubo Li wrote:
[...]
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
[...]
> +static struct regmap_config fsl_pwm_regmap_config = {

This can be static const, but since it's the only comment I can fix that
up myself when applying.

Thierry

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8bsgAAoJEN0jrNd/PrOh3acP/1FvHmFjy+wDsMtfsMV1/mN0
gtpsL1b4y1OFBirYhQVom9BvjIGJ30q/btulGRcbhW/T6MUuBuQIWqe/2tneLrMR
YI7IiGkYsMva+wdIGaqsXg+vdFHp5m32AI+hzPL4M+ueDqFKq0pr/AwB57DOW5Bm
6MP46kMNnpA9ZjkLdpEnMAHWZUtaBBOJOOGqUadqsFkX0jckpuRXJH/qbyP9SE5i
c7D87QY4bNRZkMmqazFoDqB0eBoc+CijX6a5lIRlGW1mrsM1m3K4kB3A8tB8opEH
fpOtRyfLjjcueWCqo3Xl40HgzVTsfv/Sqprd3+sgQ4q7YLSw/snoud8EDJdujxoe
SNVi1h+lFeA9YkZYPb8QFIDihIY5gRufn8P49e1jjDChSwVy11Qkp0hVgIAoAZwr
sNuJwR2eQyqNM8zJAiDE8axki3saxFYO+vGGND+1T8HhM7qjd0/rzmyVTTh6caw5
4UFVo95916A/km3RzVeRYTxTs9useFD6TDP92xZncZei7gcG8FANJNu9isrtDKQ6
5dyaq7GhYesBPorVWMLwLFIfKOUWWdis9IHpU01gaGZXzvUHXxDobKdhP7BDaf5I
FVIs6dwriJkQ3ZYrbOrD7vqOlPqpI0R26RCzPbxbJ5eYO4bXlfaHnO04GmsQq+DB
7+RVO5vuhdXOhjLCj8q7
=6iQh
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
