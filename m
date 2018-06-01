From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jun 1 (pwm/pwm-stm32)
Date: Fri, 1 Jun 2018 12:58:37 -0700
Message-ID: <daca554e-90ea-de33-845e-65a13d9acfe2@infradead.org>
References: <20180601205621.11f1b9dd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601205621.11f1b9dd@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 06/01/2018 03:56 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180531:
> 


on i386:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.0':
pwm-stm32.c:(.text+0xa01): undefined reference to `stm32_timers_dma_burst_read'

when CONFIG_PWM_STM32=y and CONFIG_MFD_STM32_TIMERS=m
and CONFIG_COMPILE_TEST=y.


-- 
~Randy
