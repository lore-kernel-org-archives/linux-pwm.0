From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period
 updates
Date: Mon, 23 Mar 2020 17:00:13 +0530
Message-ID: <09dac13d-44b0-80c6-fdbb-54bfc6f48e36@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hi All,

On 12/03/20 9:52 AM, Lokesh Vutla wrote:
> This series fixes minor issues in config callback and allows for on the
> fly updates for pwm period and duty cycle. This is mainly intended to
> allow pwm omap dmtimer to be used for generating a 1PPS signal that can be
> syncronized to PTP clock in CPTS module available in AM335x and AM57xx SoCs.
> 
> Series depends on the following series:
> - https://patchwork.kernel.org/patch/11379875/
> - https://patchwork.kernel.org/project/linux-omap/list/?series=251691

Gentle ping on this series :) The above dependencies are merged into timer tree
and below is the immutable branch:

https://git.linaro.org/people/dlezcano/linux.git/log/?h=timers/drivers/timer-ti-dm

Thanks and regards,
Lokesh
