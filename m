From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/4] pwm: sirf: add dt-binding document
Date: Tue, 18 Mar 2014 22:13:40 +0100
Message-ID: <20140318211340.GF5917@mithrandir>
References: <1394013583-6352-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:42122 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757888AbaCRVNn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Mar 2014 17:13:43 -0400
Content-Disposition: inline
In-Reply-To: <1394013583-6352-1-git-send-email-21cnbao@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, devicetree@vger.kernel.org, Barry Song <Baohua.Song@csr.com>


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2014 at 05:59:43PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
>=20
> this patch adds dt-binding document for pwm-sirf. here the controller clo=
ck
> can't generate PWM signals, so we need seperate clock as signal source.

Please capitalize properly. Also since the binding document should be OS
agnostic, it shouldn't be using the name of the driver in the Linux
kernel.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documen=
tation/devicetree/bindings/pwm/pwm-sirf.txt
> new file mode 100644
> index 0000000..47851ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
> @@ -0,0 +1,23 @@
> +SiRF prima2 & atlas6 PWM drivers
> +
> +Required properties:
> +- compatible: "sirf,prima2-pwm"
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index =
of the
> +  PWM to use and the second cell is the period in nanoseconds.

The canonical way to describe this property is:

	- #pwm-cells: Should be 2. See pwm.txt in this directory for a description=
 of
	  the cells format.

> +- clocks: from common clock binding: the 1st clock is for PWM controller=
 the
> +  other clocks are the sources to generate PWM signals
> +- clock-names : The first one is the name of the clock for PWM, others a=
re names
> +  of clock sources to generate PWM signal, e.g.sigsrc0 ~sigsrc4. For pri=
ma2 and
> +  atlas6, sigsrc0 is OSC with 26MHz, sigsrc3 is RTC with 32KHz, others a=
re PLLs.
> +  Generally, PWM module uses the OSC as clock source to generate PWM sig=
nals.

I think a more common way to write this is:

	- clocks: Must contain an entry for each entry in clock-names.
	  See ../clocks/clock-bindings.txt for details.
	- clock-names: Must include the following entries:
	  - pwmc: PWM controller clock
	  - sigsrc0: source clock for ???
	  - ...
	  - sigsrc4: source clock for ???

And perhaps given the requirements on prima2 and atlas6 (are those SoC
generations or boards?) specify what each clock should be set to.

If prima2 and atlas6 are boards, then the binding shouldn't mention them
at all.

Thierry

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKLcEAAoJEN0jrNd/PrOhSPUP/i8aDvt+bY26YlenxOh8GDlX
XP4ld9YezlCpV2QUroPBsx+h3beuoIBcHKhnhcdrtnrTyzp+gOvwANr8rEqWPoZg
QjRnx9Bw4YumpIlY7yBaVbOYewfVHcIsbQK4BuQV7Ow50AZHiaan77L43lolLXiM
rN0T6UUjp2z3TJBpEuZtHQF2zBiMVgxu0sLQqCHABs8rmnvXLtJse9j/lMHPzxWG
x07egdG+hYxs8XkUm43/jzJ5qzdnuOCPkAj85Xb3lM5P/MSNy6bpr3L/wviKtYNb
fXCLY0vxiF/evTneA/HVolTByIAC5jtkrJbUiXBQQGZgW4eWgfkxoZ9ycUL3OKuo
4Wt6Apj0VZorAJ0bzhDSI0+M0l17VXaIpxDqPyzlcp1uZG9qgegkRhO5gbXScaRJ
8Wp/6OBL5op3uflvAvivUwfTXfCTFpq4fDoS//rMxYXPra8SvppOIJSErobprsqW
Qyr/lAi5k9Z7m6fHmeWtvfW7Tznc2RB9+n73g5LKzalBRCwAtPXVjC5Cdi87A60y
+NJiOMXBqwpM8z0tFqUtkCiOOZzKd2YsK/r4X8v1iB+8PHrtnvoMzgc0yax44qtM
7gFg2H7ljFRGlb02hcK6wzhY2Dkx8ZbPtGKP0bwqpn79sw46wCxadzRWuW5J3oNS
XbtbW+B6kHcNq26Fs+lB
=52Rr
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
