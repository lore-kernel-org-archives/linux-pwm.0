From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Date: Tue, 10 Mar 2020 16:43:28 -0500
Message-ID: <20200310214328.GA21450@bogus>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45649 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJVnc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 17:43:32 -0400
Content-Disposition: inline
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
Cc: treding@nvidia.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, jonathanh@nvidia.com, bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Sandipan Patra <spatra@nvidia.com>

On Thu, 5 Mar 2020 16:57:33 +0530, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>  drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>  2 files changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
