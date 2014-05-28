From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 15/15] misc: atmel_pwm: remove obsolete driver
Date: Wed, 28 May 2014 16:35:34 -0700
Message-ID: <20140528233534.GA3580@kroah.com>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, May 29, 2014 at 01:20:18AM +0200, Alexandre Belloni wrote:
> The misc/atmel_pwm is not used by any mainlined boards and has been replaced by
> the pwm-driver using the generic PWM framework.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
