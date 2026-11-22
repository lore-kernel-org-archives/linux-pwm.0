Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383904;
	b=AtsSJv5wialPD0WWPoR1mHpKq48rTmbzLNRj7Z0ep7s26IkRzwHYyhXHiEeU5aHJ8YjF
	 CeIjjbHbQe4uXTWguC13zRFuKD1Kb4KrMFaYgtqaiqd6Thlt8FPa+SSJDZHZrCBIHxIJ5
	 cfrGmK/ZDHPNCUUbbY7ME5z3fi/5iGV9jNhpAc6SjusvnUzxKtf8awj1gmgK3j8dDxO5j
	 WyqLbJ573UQm5QHRt7iyP49dSPMLgalhDF4NqM/21+UxM+o/dNyWrUsMDGznO0+O/kReU
	 THztE1ScjDgct5WEboMrjQp0gKYY3G2db7PsPcYWD2XVf38XbV2i6kk3yjHCgHhSC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=b50zLsvvGRcvgvDriMx8gDLrh8tprTr6wGiggUvHjMs=;
	b=vnwN+M8AXNa4GE/9HcQiis5Qr+5ZEvzJQdXbegU39mpXSIYuXF4Q2LPrwupoYWBTOVBR
	 FpI0m35T6uEbOrJxM3k3PwQfhCoZWCbrINwVukj/Lowc0fjx4OScNxYEAaPVSIYZy6Huy
	 4igLPv1kaJtgjnr/KngX/nZEXTfXLaDGDXv0mwQe7AahNKen63UXPnkCeXT+MdXnkn268
	 YTwvrLtcNW9jKUX1h9onB/iAn+ThfVO0+1Jb6D3w/zViTuBbMASoYhEif2k2+5ROegERL
	 87npdUuB8k35q878B/RYkX+b3YazE12MXS2Gt0UIPnSdFrd0S6JIndMONnFn9kaXIww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWwKleOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512A606A31A;
	Sun, 22 Nov 2026 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWwKleOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65CF1F000C0;
	Sun, 22 Nov 2026 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383903;
	bh=b50zLsvvGRcvgvDriMx8gDLrh8tprTr6wGiggUvHjMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CWwKleObXQWz2vPfgUCmrj9fEWZy+oV4RnyXyKIEv4G8dYb3DKdAbPqRIgWIZ+jQZ
	 ZWjUbYWnPoA5XLsCcBlwscCCWQYz6AKWhzfvOEwO1fl1wYepe9cAP7R2WKBWMciuTm
	 3ueObXfw4I/Vj899wB1YlBZ37+6ouHyWasbO9Mf5oSnKvbE9CBEpozMZcN4k5ERJYD
	 rwa6FlHJv5QzZ/7xHppRI5mDQ+Ilt3cssTp8yT9R49sIwXdAMVckfV+8y6iF4xvPd9
	 fz3YF2nr2LtFk+EQEJPG5zDpeyD0mnlbX/1+elOO7nvrMj3zwn7nZ62Xal3Smkgkfu
	 Vu/XDlDzhmMsA==
Date: Sun, 22 Nov 2026 21:44:55 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	David Lechner <dlechner@baylibre.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Grant Erickson <marathon96@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>, imx@lists.linux.dev,
	Joachim Eastwood <manabian@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Juxin Gao <gaojuxin@loongson.cn>,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	NeilBrown <neil@brown.name>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sai Masarapu <Sai.Masarapu@imgtec.com>,
	Sandipan Patra <spatra@nvidia.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Xiubo Li <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 0/8] pwm: Fix various bugs reported by Sashiko
Message-ID: <20261122214455.GF70182@joneslee-macbookpro.roam.internal>
References: <20261105143847.2559586-1-lee@kernel.org>
 <awA6F830Ve_-vXBg@monoceros>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awA6F830Ve_-vXBg@monoceros>

On Fri, 20 Nov 2026, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Thu, Nov 05, 2026 at 02:38:02PM +0000, Lee Jones wrote:
> > These issues were reported by Sashiko.
> > 
> > Lee Jones (8):
> >   pwm: tegra: Prevent 32-bit period truncation and division by zero
> >   pwm: mxs: Return early when disabling and fix error-path clock leak
> >   pwm: loongson: Fix 32-bit control register truncation in
> >     pwm_loongson_set_polarity()
> >   pwm: axi-pwmgen: Enable clocks before accessing hardware registers in
> >     probe()
> >   pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
> >   pwm: omap-dmtimer: Handle negative error codes from get_pwm_status()
> >   pwm: tiehrpwm: Enable runtime PM before registering PWM chip
> >   pwm: img: Unregister PWM chip before disabling runtime PM and clocks
> 
> I applied patches #3 and #4 to
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> , for the others there is feedback to address on your side.
> 
> Thanks for your patches, very appreciated!

No problem.  I'll turn these around shortly.

-- 
Lee Jones
