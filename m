From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] ARM: pwm: sun6i: add support the Allwinner A31
 PWM.
Date: Wed, 15 Feb 2017 16:16:07 -0600
Message-ID: <20170215221607.ovz3vb6wihzfzoi7@rob-hp-laptop>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-4-git-send-email-lis8215@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36108 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdBOWQK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2017 17:16:10 -0500
Content-Disposition: inline
In-Reply-To: <1486489846-662-4-git-send-email-lis8215@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: lis8215@gmail.com
Cc: linux-sunxi@googlegroups.com, thierry.reding@gmail.com, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Feb 07, 2017 at 08:50:45PM +0300, lis8215@gmail.com wrote:
> From: Siarhei Volkau <lis8215@gmail.com>
> 
> This patch introduce the sun6i PWM driver itself:
>  - sun6i register operations,
>  - sun6i prescaler table,
>  - DT bindings for A31 SoC,
>  - documentation update.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  3 +-
>  drivers/pwm/pwm-sun4i.c                            | 71 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org> 
