Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16B1A9FB0
	for <linux-pwm@vger.kernel.org>; Mon,  6 Jul 2026 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783298074; cv=none; b=DOMI+7QTrRL9eO1CG+22f3/Z6dl4hS01YvysJQCWmofk+MLETTDDi9LLlyJscXdVz96DU8PkobKk/LMfuLAhCI/jmy3KLJY54WJCNICjyVR7T1k6foYhQDcHSOovFUWNotNFJiyywhSJD/xCp//3Y6TP/ILy9KfnVzYpoQplfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783298074; c=relaxed/simple;
	bh=2PxUxZPMKUCuY9XPy73Y/KPmQ0r97rw0cg10OraDCjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MniUEvLZE7TQUMdzBxO5g1ILB0hnnMm6y/btqyk9ETd4W0MbZ9QtySMBXk/EsKId4Zju1cL1g07EGmWZsrLchRYCXm2Osk6FnND68qn4Zx69KE5P6clPKuD7aVF/+keTm0dwA78vozKQA+ikaVAKQQ/efNrsRZl31QgTFVsVWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLsuUED9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLsuUED9"
Message-ID: <973f3d6f-6ff4-4685-9c9f-b07987f74d98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783298059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrjdzAhnc0P88BFwUH/b6uj52WFQfIRb2R1u4QFCds=;
	b=mLsuUED9ENIp3ed3h8bdKFYcEwFgoRzOELLNc1jLIXF6taZ+WEztXLwd9/BAKQWvUz2Hs3
	3EKLIatmB5Z+Df3dgdlCr8bmpTJQbWFj3Jp6WCvzaQnW40BXVB4LUsJRj7jQdhncagFIYu
	oCbFYryMjDBm1fu5il4d+x3rl9gBRyM=
Date: Mon, 6 Jul 2026 08:33:47 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/5] pwm: Unify coding style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, linux-pwm@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Michael Walle
 <mwalle@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Hammer Hsieh <hammerh0314@gmail.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Alexey Charkov <alchark@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev,
 imx@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev
References: <cover.1783263835.git.ukleinek@kernel.org>
 <20de6cd60c2938aad2d21397b92742849418ab1b.1783263835.git.ukleinek@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chen Wang <chen.wang@linux.dev>
In-Reply-To: <20de6cd60c2938aad2d21397b92742849418ab1b.1783263835.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/5/2026 11:14 PM, Uwe Kleine-König (The Capable Hub) wrote:
>   - Use a single space in a of_device_id array terminator; A single space
>     after the opening { and before the closing } in non-empty
>     initializers;
>   - No comma after an array terminator;
>   - Also no trailing comma after a named initializer iff the
iff -> if
>     closing } is on the same line;
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

[......]

> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> index 7d07b0ca7d29..0b6461172e6a 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -225,11 +225,10 @@ static const struct sg2042_chip_data sg2044_chip_data = {
>   static const struct of_device_id sg2042_pwm_ids[] = {
>   	{
>   		.compatible = "sophgo,sg2042-pwm",
> -		.data = &sg2042_chip_data
> -	},
> -	{
> +		.data = &sg2042_chip_data,
> +	}, {
>   		.compatible = "sophgo,sg2044-pwm",
> -		.data = &sg2044_chip_data
> +		.data = &sg2044_chip_data,
>   	},
>   	{ }
>   };

Changes to sophgo related files：

Reviewed-by: Chen Wang <chen.wang@linux.dev>

Thanks,

Chen

[......]


