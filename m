From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4] clk: Add PWM clock driver
Date: Fri, 13 Feb 2015 09:16:02 -0800
Message-ID: <54DE3152.6050204@codeaurora.org>
References: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52572 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbBMRQF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Feb 2015 12:16:05 -0500
In-Reply-To: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Mike Turquette <mturquette@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 12/12/14 02:47, Philipp Zabel wrote:
> +
> +const struct clk_ops clk_pwm_ops = {

static?

> +	.prepare = clk_pwm_prepare,
> +	.unprepare = clk_pwm_unprepare,
> +	.recalc_rate = clk_pwm_recalc_rate,
> +};
> +
> +int clk_pwm_probe(struct platform_device *pdev)

static?

> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_init_data init;
> +	struct clk_pwm *clk_pwm;
> +	struct pwm_device *pwm;
> +	const char *clk_name;
> +	struct clk *clk;
> +	int ret;
[...]
> +}
> +
> +int clk_pwm_remove(struct platform_device *pdev)

static?

> +{
> +	of_clk_del_provider(pdev->dev.of_node);
> +
> +	return 0;
> +}
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

