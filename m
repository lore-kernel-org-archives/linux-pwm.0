From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Date: Fri, 6 Mar 2020 08:28:05 +0100
Message-ID: <20200306072805.qraegjo7xmebelu5@pengutronix.de>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58489 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCFH2R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 02:28:17 -0500
Content-Disposition: inline
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>
Cc: treding@nvidia.com, robh+dt@kernel.org, jonathanh@nvidia.com, bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:57:33PM +0530, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>

Looks good to me,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
