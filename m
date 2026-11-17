Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926644;
	b=r3bbfoJVy/PIwfnUyRT8THySeqr4pxHDH0WceA48LyGQkUzVpapuv1a98icm/mEKvj4b
	 suwSG7WROkSHXMK3vjLiBvi2hw33ukr1uV4U8VLBded4P7+DhOPKrIOYqoW+5aWg9TBw0
	 nl3SFGBVdT/AylK1v93Pi0GdtG2Hx5tH+Kvu2CZF6MBxtQb4o9ojv9QA9ErFnUBaiJUI9
	 1ZKqUolBtywLn49J+DliGa4GrLhVqpfZLze7oi3b816ON+/25Ytg04B7LiACixoO9vuqb
	 clSKW9JYbBHrQAQ1vAvhRP9U8ApyHBICerzp6H5VHIEuyqwLYhZgoWLA+52XOfKKskw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926644;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5kbl0iyyIPyhHgE6lBDF/EkGEn92mMrlFsxtkKsy+D8=;
	b=cSh/69kvtOPyiWo7POakGsrUOoEdimKowgBj3iM+X3gflgeSMnq5QOlUvbLWUNOTtjVa
	 ZDLWVlky+m2VgBk6YAkuirkx9TTvvrWSfOulnlwTq0cRFk9kL3r8N6J9HnbrxoiYdiBfL
	 aG6qHUa4i0INv/TonrAguoEposZdMgta6OA7Q/3HnNAvyGj0NnVUUoa+K/P6JWxK8bFON
	 Hw+JtNy3t8Bw+8fS8+0t+FYrcyteXQz9HP1LhpD/ZNpcCUtQOi9gnzmZH/WTpAcEgWAlv
	 qnwfEdI42ZrF/dj7pRhnkxwQ/a7YWT3ncA8GQreRBE6rJKJTSQwEjc6GvtQkoVBfQKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsxR1C6m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EA3C5606A31C;
	Tue, 17 Nov 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsxR1C6m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 16B781F000C4;
	Tue, 17 Nov 2026 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926643;
	bh=5kbl0iyyIPyhHgE6lBDF/EkGEn92mMrlFsxtkKsy+D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FsxR1C6mEsyhDYgtZrfgj0CjWiOEfj0D6COdEjdx1spFCylPvFwjNq3u8RmtzRHm1
	 xaU2GDojIUBwqdPht8VPT3CTviHPbs+4zzoG6vjwbUuZn2YBIdvCo5UP6QANwFKI+7
	 Jk3iLoGsLVISATSKR5hujN0g3ORYAkkhWYkVvhhHHdpxCAI5UBhQnurlgCC/4JzG2j
	 wYYTq5eicJYCEye5V36RuobTQkQTHR3vS/bkCegjsNiU8goItukoSAE7Guu+r3LOMI
	 COT3A/DN87F3IT29inkSMtLOGsqX0M94WuMfw3BUs+5PgJQtDise28BofLHIeVlhVE
	 T7EpPDkiKm0Pw==
Date: Tue, 17 Nov 2026 15:44:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: qcom: add Shikra PWM controller support
Message-ID: <avxh7fQliDF_wCms@monoceros>
References: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
 <20261116-pwm_qcom_shikra-v1-2-67ee4553adc5@oss.qualcomm.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="munz3fsjlz5cz7th"
Content-Disposition: inline
In-Reply-To: <20261116-pwm_qcom_shikra-v1-2-67ee4553adc5@oss.qualcomm.com>


--munz3fsjlz5cz7th
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] pwm: qcom: add Shikra PWM controller support
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 12:29:49PM +0530, Taniya Das wrote:
> Add support for the Pulse Width Modulation (PWM) controller on Qualcomm
> Shikra SoCs.
>=20
> The controller has a shared output-enable register and up to ten frame
> blocks with independent configuration registers. Model each available
> frame from its DT child node, and retain the shared AHB and PWM core
> clocks while an output is active.
>=20
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/pwm/Kconfig    |  13 +
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-qcom.c | 685 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 699 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index aacd800687e7c98b2272ddb01447356349425032..ae229e922521e97d88610887d=
a5ccb0f7433fbd3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -566,6 +566,19 @@ config PWM_PXA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-pxa.
> =20
> +config PWM_QCOM
> +	tristate "Qualcomm PWM support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on COMMON_CLK && HAS_IOMEM && OF
> +	select REGMAP_MMIO
> +	help
> +	  PWM framework driver for the PWM block found on Qualcomm SoCs,
> +	  which supports multiple PWM frames. Each frame can be
> +	  configured independently of the others.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called pwm-qcom.
> +
>  config PWM_RASPBERRYPI_POE
>  	tristate "Raspberry Pi Firmware PoE Hat PWM support"
>  	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7e2c34cc4f6a955b04edcdd08721264d0d477f2e..a7e0095b573448cb643b19f4d=
a2e6f02ada4bc39 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> +obj-$(CONFIG_PWM_QCOM)		+=3D pwm-qcom.o
>  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
>  obj-$(CONFIG_PWM_RENESAS_RCAR)	+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> diff --git a/drivers/pwm/pwm-qcom.c b/drivers/pwm/pwm-qcom.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9b15cdcaa5c76a3f2a9d7871b=
4e12d52cf89610a
> --- /dev/null
> +++ b/drivers/pwm/pwm-qcom.c
> @@ -0,0 +1,685 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */

Please describe the general hardware properties in a "Limitations"
paragraph. Look at other drivers for the format and what to mention
there.

> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>

Don't include <linux/mod_devicetable.h>. <linux/platform_device.h>
already gives you of_device_id, so just drop it.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/* Offsets */
> +#define PWM_TOPCTL0			0x0
> +
> +/* offsets per frame */
> +#define PWM_CTL0			0x0
> +#define PWM_CTL1			0x4
> +#define PWM_CTL2			0x8
> +#define PWM_CYC_CFG			0xc
> +#define PWM_UPDATE			0x10
> +#define PWM_RESET			0x18
> +
> +#define PWM_FRAME_POLARITY_BIT		BIT(0)
> +#define PWM_FRAME_ROLLOVER_CNT_BIT	BIT(4)
> +#define PWM_FRAME_RESET_BIT		BIT(0)

Please add a proper prefix to these defintions. "PWM_UPDATE" sounds much
more generic than it is.

Also ideally the bit defintions start with the register name.

> +/* All per-frame 16-bit value fields (CYC_CFG, CTL1, CTL2). */
> +#define PWM_FRAME_VAL_MASK		GENMASK(15, 0)
> +
> +/*
> + * struct qcom_pwm_priv_data - per-compatible hardware description
> + * @max_channels: number of frames supported by this hardware variant.
> + * @pwm_reset_support: whether PWM_RESET is implemented, allowing the pe=
riod
> + *	to be changed after it has already been set once.
> + * @pwm_cnt_rollover: whether PWM_FRAME_ROLLOVER_CNT_BIT is implemented,
> + *	needed so period changes don't get stuck waiting on the counter.
> + */
> +struct qcom_pwm_priv_data {
> +	unsigned int max_channels;
> +	bool pwm_reset_support;
> +	bool pwm_cnt_rollover;
> +};
> +
> +/*
> + * struct qcom_pwm_frames - Information regarding per PWM frame
> + * @frame_id: Id number associated with each frame.
> + * @polarity: Current polarity of the particular frame.
> + * @regmap: regmap covering this frame's own register block. Each frame =
now
> + *	owns its own "reg" range in DT, so registers are accessed at their
> + *	plain offsets within this regmap instead of as an offset into a
> + *	shared parent regmap.
> + * @current_period_ns: Current period of the particular frame.
> + * @current_duty_ns: Current duty cycle of the particular frame.
> + * @current_freq: Current frequency of frame.
> + * @freq_set: This bool flag is responsible for setting period once per =
frame.
> + * @frame_lock: mutex lock per frame.
> + * @cnt_rollover_en: This bool flag is used to set rollover bit per fram=
e.
> + */
> +struct qcom_pwm_frames {
> +	u32	frame_id;
> +	u32	polarity;
> +	struct regmap *regmap;
> +	u64	current_period_ns;
> +	u64	current_duty_ns;
> +	unsigned long current_freq;
> +	bool	is_enabled;
> +	bool	freq_set;
> +	struct mutex frame_lock; /* PWM per frame lock */
> +	bool cnt_rollover_en;

Only a single space between type name and member name.

> +};
> +
> +/*
> + * struct qcom_pwm_chip - Information regarding per PWM block
> + * @regmap: regmap of the shared PWM_TOPCTL0 enable register.
> + * @frames: structure for all frames of each PWM block.
> + * @priv_data: per-compatible hardware description.
> + * @ahb: AHB clock providing access to the PWM block.
> + * @core: shared clock providing the PWM frame rate.
> + * @lock: mutex lock per chip (enable/disable path).
> + * @num_frames: number of frames in each PWM block.
> + */
> +struct qcom_pwm_chip {
> +	struct regmap		*regmap;
> +	struct qcom_pwm_frames	*frames;
> +	const struct qcom_pwm_priv_data	*priv_data;
> +	struct clk		*ahb;
> +	struct clk		*core;
> +	/* This lock to be used for Enable/Disable as it is per PWM channel */
> +	struct mutex		lock;
> +	u32			num_frames;
> +};
> +
> +static inline struct qcom_pwm_chip *to_qcom_pwm_chip(struct pwm_chip *ch=
ip)

If you rename that to qcome_pwm_from_chip it also has the common
function prefix.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int qcom_pwm_clks_enable(struct qcom_pwm_chip *chip)
> +{
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(chip->ahb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(chip->core);
> +	if (ret)
> +		clk_disable_unprepare(chip->ahb);
> +
> +	return ret;
> +}
> +
> +static void qcom_pwm_clks_disable(struct qcom_pwm_chip *chip)
> +{
> +	clk_disable_unprepare(chip->core);
> +	clk_disable_unprepare(chip->ahb);
> +}
> +
> +static int qcom_pwm_calc_frequency(struct qcom_pwm_chip *chip,
> +				   u64 period_ns, unsigned long rate, u32 hw_idx)
> +{
> +	struct regmap *frame_regmap =3D chip->frames[hw_idx].regmap;
> +	u64 cycles;
> +	int ret;
> +
> +	/*
> +	 * PWM client can set the period only once if the HW version does
> +	 * not support reset functionality.
> +	 */
> +	if (chip->frames[hw_idx].freq_set && !chip->priv_data->pwm_reset_suppor=
t)
> +		return 0;
> +
> +	/*
> +	 * Number of core-clock cycles in one PWM period. Round down so the
> +	 * implemented period never exceeds the requested one, as the PWM API
> +	 * requires. PWM_CYC_CFG holds (cycles - 1) in its low 16 bits, so
> +	 * cycles is bounded to [2, 65536], i.e. an output frequency from
> +	 * rate / 2 down to rate / 65536.
> +	 */
> +	cycles =3D mul_u64_u64_div_u64(period_ns, rate, NSEC_PER_SEC);
> +	if (cycles < 2 || cycles > 65536) {
> +		dev_dbg(regmap_get_device(frame_regmap),
> +			"period %llu ns out of range for rate %lu Hz\n",
> +			period_ns, rate);
> +		return -ERANGE;
> +	}
> +
> +	ret =3D regmap_update_bits(frame_regmap, PWM_CYC_CFG,
> +				 PWM_FRAME_VAL_MASK, cycles - 1);
> +	if (ret)
> +		return ret;
> +
> +	chip->frames[hw_idx].current_freq =3D div64_ul(rate, cycles);
> +	chip->frames[hw_idx].freq_set =3D true;
> +	chip->frames[hw_idx].current_period_ns =3D period_ns;
> +
> +	return 0;
> +}
> +
> +static int qcom_pwm_get_state(struct pwm_chip *pwm_chip, struct pwm_devi=
ce *pwm,
> +			      struct pwm_state *state)
> +{
> +	struct qcom_pwm_chip *chip =3D to_qcom_pwm_chip(pwm_chip);
> +	struct qcom_pwm_frames *frame =3D &chip->frames[pwm->hwpwm];
> +	unsigned long rate;
> +	u32 topctl, ctl0, ctl1, cyc_cfg, cycles;
> +	int ret;
> +
> +	if (!frame->regmap)
> +		return -ENODEV;
> +
> +	/* Both clocks are needed for register access. */
> +	ret =3D qcom_pwm_clks_enable(chip);
> +	if (ret)
> +		return ret;
> +
> +	rate =3D clk_get_rate(chip->core);
> +	if (!rate) {
> +		ret =3D -EINVAL;
> +		goto err_clks;
> +	}
> +
> +	mutex_lock(&frame->frame_lock);
> +
> +	ret =3D regmap_read(chip->regmap, PWM_TOPCTL0, &topctl);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_read(frame->regmap, PWM_CTL0, &ctl0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_read(frame->regmap, PWM_CTL1, &ctl1);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_read(frame->regmap, PWM_CYC_CFG, &cyc_cfg);
> +	if (ret)
> +		goto out;
> +
> +	cycles =3D (cyc_cfg & PWM_FRAME_VAL_MASK) + 1;
> +	state->enabled =3D !!(topctl & BIT(frame->frame_id));
> +	state->polarity =3D (ctl0 & PWM_FRAME_POLARITY_BIT) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	/*
> +	 * Round up so re-applying the returned state reproduces the same
> +	 * register values, since qcom_pwm_config() rounds the period and duty
> +	 * cycle down.
> +	 */
> +	state->period =3D DIV_ROUND_UP_ULL((u64)cycles * NSEC_PER_SEC, rate);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)(ctl1 & PWM_FRAME_VAL_MASK)=
 *
> +					     NSEC_PER_SEC, rate);
> +out:
> +	mutex_unlock(&frame->frame_lock);
> +err_clks:
> +	qcom_pwm_clks_disable(chip);
> +
> +	return ret;
> +}
> +
> +static int qcom_pwm_config(struct qcom_pwm_chip *chip,
> +			   u32 hw_idx, u64 duty_ns, u64 period_ns, int polarity)
> +{
> +	struct regmap *frame_regmap =3D chip->frames[hw_idx].regmap;
> +	u64 ctl1, duty_percent;
> +	unsigned long rate;
> +	u64 current_period =3D period_ns;
> +	bool clks_enabled =3D false;
> +	int ret;
> +	u32 cyc_cfg;
> +
> +	mutex_lock(&chip->frames[hw_idx].frame_lock);
> +
> +	if (!chip->frames[hw_idx].is_enabled) {
> +		ret =3D qcom_pwm_clks_enable(chip);
> +		if (ret)
> +			goto err_unlock;
> +		clks_enabled =3D true;
> +	}
> +
> +	rate =3D clk_get_rate(chip->core);
> +	if (!rate) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Set the counter rollover enable bit, so that counter doesn't get stu=
ck
> +	 * in period change configuration.
> +	 */
> +	if (chip->priv_data->pwm_cnt_rollover && !chip->frames[hw_idx].cnt_roll=
over_en) {
> +		ret =3D regmap_update_bits(frame_regmap, PWM_CTL0,
> +					 PWM_FRAME_ROLLOVER_CNT_BIT,
> +					 PWM_FRAME_ROLLOVER_CNT_BIT);
> +		if (ret)
> +			goto out;
> +
> +		chip->frames[hw_idx].cnt_rollover_en =3D true;
> +	}
> +
> +	if (chip->frames[hw_idx].freq_set &&
> +	    chip->frames[hw_idx].current_period_ns !=3D period_ns) {
> +		if (chip->priv_data->pwm_reset_support) {
> +			ret =3D regmap_update_bits(frame_regmap, PWM_RESET,
> +						 PWM_FRAME_RESET_BIT,
> +						 PWM_FRAME_RESET_BIT);
> +			if (ret)
> +				goto out;
> +		} else {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	ret =3D qcom_pwm_calc_frequency(chip, current_period, rate, hw_idx);
> +	if (ret)
> +		goto out;
> +
> +	if (chip->frames[hw_idx].polarity !=3D polarity) {
> +		ret =3D regmap_update_bits(frame_regmap, PWM_CTL0,
> +					 PWM_FRAME_POLARITY_BIT, polarity);
> +		if (ret)
> +			goto out;
> +
> +		chip->frames[hw_idx].polarity =3D polarity;
> +	}
> +
> +	ctl1 =3D DIV_ROUND_CLOSEST(rate, chip->frames[hw_idx].current_freq);
> +	duty_percent =3D mul_u64_add_u64_div_u64(duty_ns, 100, current_period /=
 2, current_period);
> +	ctl1 =3D mul_u64_add_u64_div_u64(ctl1, duty_percent, 50, 100);
> +
> +	ret =3D regmap_read(frame_regmap, PWM_CYC_CFG, &cyc_cfg);
> +	if (ret)
> +		goto out;
> +
> +	if ((ctl1 > cyc_cfg || ctl1 =3D=3D 0) && duty_ns !=3D 0) {
> +		dev_err(regmap_get_device(frame_regmap),
> +			"duty cycle out of valid range\n");
> +		ret =3D -ERANGE;
> +		goto out;
> +	}
> +
> +	ret =3D regmap_update_bits(frame_regmap, PWM_CTL2, PWM_FRAME_VAL_MASK, =
0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame_regmap, PWM_CTL1, PWM_FRAME_VAL_MASK, =
ctl1);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame_regmap, PWM_UPDATE, BIT(0), 1);
> +	if (ret)
> +		goto out;
> +
> +	chip->frames[hw_idx].current_duty_ns =3D duty_ns;
> +out:
> +	if (clks_enabled)
> +		qcom_pwm_clks_disable(chip);
> +err_unlock:
> +	mutex_unlock(&chip->frames[hw_idx].frame_lock);
> +
> +	return ret;
> +}
> +
> +static int qcom_pwm_enable(struct qcom_pwm_chip *chip,
> +			   struct pwm_device *pwm)
> +{
> +	struct device *dev =3D regmap_get_device(chip->regmap);
> +	int ret;
> +	u32 val, hw_idx =3D pwm->hwpwm;
> +
> +	ret =3D qcom_pwm_clks_enable(chip);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	dev_dbg(dev, "enable: hw_idx=3D%u frame_id=3D%u\n",
> +		hw_idx, chip->frames[hw_idx].frame_id);
> +
> +	val =3D BIT(chip->frames[hw_idx].frame_id);
> +	ret =3D regmap_update_bits(chip->regmap, PWM_TOPCTL0, val, val);
> +	if (!ret)
> +		chip->frames[hw_idx].is_enabled =3D true;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	if (ret)
> +		goto err_clks;
> +
> +	return 0;
> +
> +err_clks:
> +	qcom_pwm_clks_disable(chip);
> +	return ret;
> +}
> +
> +static int qcom_pwm_disable(struct qcom_pwm_chip *chip,
> +			    struct pwm_device *pwm)
> +{
> +	struct device *dev =3D regmap_get_device(chip->regmap);
> +	u32 val, hw_idx =3D pwm->hwpwm;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	dev_dbg(dev, "disable: hw_idx=3D%u\n", hw_idx);
> +
> +	val =3D BIT(chip->frames[hw_idx].frame_id);
> +	ret =3D regmap_update_bits(chip->regmap, PWM_TOPCTL0, val, 0);
> +	if (!ret)
> +		chip->frames[hw_idx].is_enabled =3D false;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	qcom_pwm_clks_disable(chip);
> +
> +	return 0;
> +}
> +
> +static int qcom_pwm_apply(struct pwm_chip *pwm_chip, struct pwm_device *=
pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct qcom_pwm_chip *chip =3D to_qcom_pwm_chip(pwm_chip);
> +	struct pwm_state curr_state;
> +	u32 hw_idx =3D pwm->hwpwm;
> +	int ret;
> +
> +	pwm_get_state(pwm, &curr_state);

Don't call PWM functions from callbacks. pwm_get_state() doesn't take
the chip lock, but that's an implementation detail that you shouldn't
rely on.

> +
> +	if (state->period &&
> +	    (state->period !=3D curr_state.period ||
> +	     state->duty_cycle !=3D curr_state.duty_cycle ||
> +	     state->polarity !=3D curr_state.polarity)) {

Don't do these checks, the PWM core already handles stuff like that.

> +		ret =3D qcom_pwm_config(chip, hw_idx, state->duty_cycle,
> +				      state->period, state->polarity);
> +		if (ret) {
> +			dev_err(pwmchip_parent(pwm_chip),
> +				"failed to update PWM configuration\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (state->enabled !=3D curr_state.enabled) {
> +		if (state->enabled)
> +			return qcom_pwm_enable(chip, pwm);
> +
> +		ret =3D qcom_pwm_disable(chip, pwm);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pwm_request(struct pwm_chip *pwm_chip, struct pwm_device=
 *pwm)
> +{
> +	struct qcom_pwm_chip *chip =3D to_qcom_pwm_chip(pwm_chip);
> +
> +	if (!chip->frames[pwm->hwpwm].regmap)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Reset the software state and the frame's own registers (the same
> + * PWM_CTL0/PWM_CTL1/PWM_CYC_CFG registers qcom_pwm_get_state() reads ba=
ck)
> + * to their power-on defaults, and disable an active PWM frame.
> + */
> +static void qcom_pwm_free(struct pwm_chip *pwm_chip, struct pwm_device *=
pwm)
> +{
> +	struct qcom_pwm_chip *chip =3D to_qcom_pwm_chip(pwm_chip);

The variable name "chip" is reserved for variables of type pwm_chip. So
please use "chip" instead of "pwm_chip" and something else for the
struct qcom_pwm_chip variables.

> +	struct qcom_pwm_frames *frame =3D &chip->frames[pwm->hwpwm];
> +	bool enabled;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	enabled =3D frame->is_enabled;
> +	mutex_unlock(&chip->lock);
> +
> +	if (enabled) {
> +		ret =3D qcom_pwm_disable(chip, pwm);
> +		if (ret) {
> +			dev_err(pwmchip_parent(pwm_chip),
> +				"failed to disable PWM on free\n");
> +			return;
> +		}
> +	}
> +
> +	ret =3D qcom_pwm_clks_enable(chip);
> +	if (ret) {
> +		dev_err(pwmchip_parent(pwm_chip),
> +			"failed to enable clocks on free\n");
> +		return;
> +	}
> +
> +	mutex_lock(&frame->frame_lock);
> +
> +	ret =3D regmap_update_bits(frame->regmap, PWM_CTL0,
> +				 PWM_FRAME_POLARITY_BIT | PWM_FRAME_ROLLOVER_CNT_BIT, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame->regmap, PWM_CTL1, PWM_FRAME_VAL_MASK,=
 0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame->regmap, PWM_CTL2, PWM_FRAME_VAL_MASK,=
 0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame->regmap, PWM_CYC_CFG, PWM_FRAME_VAL_MA=
SK, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D regmap_update_bits(frame->regmap, PWM_UPDATE, BIT(0), 1);
> +	if (ret)
> +		goto out;
> +
> +	if (chip->priv_data->pwm_reset_support) {
> +		ret =3D regmap_update_bits(frame->regmap, PWM_RESET,
> +					 PWM_FRAME_RESET_BIT, PWM_FRAME_RESET_BIT);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	frame->freq_set =3D false;
> +	frame->current_period_ns =3D 0;
> +	frame->current_duty_ns =3D 0;
> +	frame->current_freq =3D 0;
> +	frame->polarity =3D 0;
> +	frame->cnt_rollover_en =3D false;
> +out:
> +	mutex_unlock(&frame->frame_lock);
> +	qcom_pwm_clks_disable(chip);
> +
> +	if (ret)
> +		dev_err(pwmchip_parent(pwm_chip),
> +			"failed to reset PWM registers on free\n");
> +}
> +
> +static const struct pwm_ops qcom_pwm_ops =3D {
> +	.request =3D qcom_pwm_request,
> +	.apply =3D qcom_pwm_apply,
> +	.free =3D qcom_pwm_free,
> +	.get_state =3D qcom_pwm_get_state,

I don't accept new drivers with .apply() and .get_state(). Please use
the waveform callbacks instead.
> +};
> +
> +static const struct regmap_config pwm_regmap_config =3D {
> +	.reg_bits   =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits   =3D 32,
> +	.fast_io    =3D true,
> +};
> +
> +static int qcom_pwm_parse_dt(struct platform_device *pdev,
> +			     struct pwm_chip *pwm_chip,
> +			     struct qcom_pwm_chip *chip)
> +{
> +	struct device *dev =3D pwmchip_parent(pwm_chip);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *frame_node;
> +	void __iomem *base;
> +	unsigned long frame_ids =3D 0;
> +	int ret;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	chip->regmap =3D devm_regmap_init_mmio(dev, base, &pwm_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(dev, PTR_ERR(chip->regmap),
> +				"failed to initialise regmap\n");
> +
> +	chip->ahb =3D devm_clk_get(dev, "ahb");
> +	if (IS_ERR(chip->ahb))
> +		return dev_err_probe(dev, PTR_ERR(chip->ahb),
> +				"failed to get ahb clock\n");
> +
> +	chip->core =3D devm_clk_get(dev, "core");
> +	if (IS_ERR(chip->core))
> +		return dev_err_probe(dev, PTR_ERR(chip->core),
> +				"failed to get core clock\n");
> +
> +	chip->frames =3D devm_kcalloc(dev, chip->num_frames,
> +				    sizeof(*chip->frames), GFP_KERNEL);

I think devm_kzalloc_objs is the right function to use here.

> +	if (!chip->frames)
> +		return -ENOMEM;
> +
> +	for_each_available_child_of_node(np, frame_node) {
> +		u32 n;
> +		struct resource res;
> +
> +		if (of_property_read_u32(frame_node, "qcom,frame-index", &n)) {
> +			of_node_put(frame_node);

If you use for_each_available_child_of_node_scoped you don't need to
care about the of_node_put() calls for earch error path.

> +			return dev_err_probe(dev, -EINVAL,
> +					"missing qcom,frame-index property in DT node\n");
> +		}
> +
> +		if (n >=3D chip->priv_data->max_channels) {
> +			of_node_put(frame_node);
> +			return dev_err_probe(dev, -EINVAL,
> +					"invalid qcom,frame-index %u\n", n);
> +		}
> +
> +		if (test_and_set_bit(n, &frame_ids)) {
> +			of_node_put(frame_node);
> +			return dev_err_probe(dev, -EINVAL,
> +					"duplicate qcom,frame-index %u\n", n);
> +		}
> +
> +		chip->frames[n].frame_id =3D n;
> +
> +		ret =3D of_address_to_resource(frame_node, 0, &res);
> +		if (ret) {
> +			of_node_put(frame_node);
> +			return dev_err_probe(dev, ret,
> +					"failed to get frame-%u resource\n", n);
> +		}
> +
> +		base =3D devm_ioremap_resource(dev, &res);
> +		if (IS_ERR(base)) {
> +			of_node_put(frame_node);
> +			return PTR_ERR(base);
> +		}
> +
> +		chip->frames[n].regmap =3D
> +			devm_regmap_init_mmio(dev, base, &pwm_regmap_config);
> +		if (IS_ERR(chip->frames[n].regmap)) {
> +			of_node_put(frame_node);
> +			return dev_err_probe(dev, PTR_ERR(chip->frames[n].regmap),
> +						 "failed to initialise frame regmap\n");
> +		}
> +
> +		mutex_init(&chip->frames[n].frame_lock);
> +	}
> +
> +	/* The hardware requires all PWM outputs to be disabled at probe. */
> +	ret =3D qcom_pwm_clks_enable(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(chip->regmap, PWM_TOPCTL0,
> +				 GENMASK(chip->priv_data->max_channels - 1, 0), 0);
> +
> +	qcom_pwm_clks_disable(chip);
> +
> +	return ret;
> +}
> +
> +static const struct qcom_pwm_priv_data shikra_pwm_data =3D {
> +	.max_channels =3D 10,
> +};

As long as there is only a single variant, just hardcode the info here.

> +static const struct of_device_id qcom_pwm_of_match[] =3D {
> +	{ .compatible =3D "qcom,shikra-pwm", .data =3D &shikra_pwm_data },
> +	{ },

Drop the trailing comma after the list terminator.

> +};
> +MODULE_DEVICE_TABLE(of, qcom_pwm_of_match);
> +
> +static int qcom_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *pwm_chip;
> +	struct qcom_pwm_chip *chip;
> +	const struct qcom_pwm_priv_data *priv;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	u32 child_count;
> +	int rc;
> +
> +	priv =3D of_device_get_match_data(&pdev->dev);
> +	if (!priv)
> +		return -EINVAL;
> +
> +	/* At least one available frame resource must be described. */
> +	child_count =3D of_get_available_child_count(np);
> +	if (!child_count)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				"at least one PWM frame must be described\n");

Error messages start with a capital letter.

> +	pwm_chip =3D devm_pwmchip_alloc(&pdev->dev, priv->max_channels, sizeof(=
*chip));
> +	if (IS_ERR(pwm_chip))
> +		return PTR_ERR(pwm_chip);
> +
> +	chip =3D to_qcom_pwm_chip(pwm_chip);
> +	chip->priv_data  =3D priv;

Single space before =3D please

> +	chip->num_frames =3D priv->max_channels;
> +	mutex_init(&chip->lock);
> +
> +	pwm_chip->ops =3D &qcom_pwm_ops;
> +
> +	rc =3D qcom_pwm_parse_dt(pdev, pwm_chip, chip);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D devm_pwmchip_add(&pdev->dev, pwm_chip);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_pwm_driver =3D {
> +	.driver		=3D {
> +		.name		=3D "qcom-pwm",
> +		.of_match_table	=3D qcom_pwm_of_match,
> +	},
> +	.probe		=3D qcom_pwm_probe,

Please use a single space before =3D.

> +};
> +
> +module_platform_driver(qcom_pwm_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--munz3fsjlz5cz7th
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr8aC0ACgkQj4D7WH0S
/k5fhgf/dOcfREDSKpy1pX8FjB6CbOwWtfiZSlmGhAJs2eSfiCYM+dLJnhKzm1YG
HPLlraPDvOZx2TreovUuDQKg7atCDFRKhjVf6mT24lfkrPN2WZJFIskAgvI6SEfP
CNtahwttjFrciyal+zb2bf5YtHIFpwgUv3KzysD8g8qvCogybBtILL2Ek79wgCq7
EajyuuY+h8MnEaleEl1HXkqxnT2mdgGVdrF0WjLhlRn/0phWsKvp8Hfu+DmD2Eg4
5tzTdBhHOIoxpYH/welgsbIGuXQ5I/0BbUyBtvSGcSOVvB3jfvjCY+uET5gzN3q8
+bpQwqf0beMdl0q2eDCGLbNc41mb+A==
=4CHV
-----END PGP SIGNATURE-----

--munz3fsjlz5cz7th--
