From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 13/16] avr32: update defconfig to use the generic PWM
 framework
Date: Wed, 19 Mar 2014 15:21:07 +0100
Message-ID: <20140319142107.GE20872@samfundet.no>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Around Wed 19 Mar 2014 14:03:26 +0100 or thereabout, Alexandre Belloni wrote:
> Now that all boards have switch to the generic PWM framework, update the
> defconfigs to use it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/configs/atngw100_mrmt_defconfig | 5 +++--
>  arch/avr32/configs/atstk1002_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1003_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1004_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1006_defconfig     | 5 +++--
>  arch/avr32/configs/merisc_defconfig        | 5 +++--
>  6 files changed, 18 insertions(+), 12 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
