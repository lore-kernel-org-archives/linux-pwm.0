From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure
 pin in suspends/resume
Date: Mon, 10 Apr 2017 15:13:16 -0500
Message-ID: <20170410201316.4rlf4bvt5jeagpsn@rob-hp-laptop>
References: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
 <1491557642-15940-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35952 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbdDJUNT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2017 16:13:19 -0400
Content-Disposition: inline
In-Reply-To: <1491557642-15940-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 07, 2017 at 03:04:01PM +0530, Laxman Dewangan wrote:
> In some of NVIDIA Tegra's platform, PWM controller is used to
> control the PWM controlled regulators. PWM signal is connected to
> the VID pin of the regulator where duty cycle of PWM signal decide
> the voltage level of the regulator output.
> 
> When system enters suspend, some PWM client/slave regulator devices
> require the PWM output to be tristated.
> 
> Add DT binding details to provide the pin configuration state
> from PWM and pinctrl DT node in suspend and active state of
> the system.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> Changes from v1:
> - Use standard pinctrl names for sleep and active state.
> 
> Changes from V2:
> - Fix the commit message and details
> ---
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
