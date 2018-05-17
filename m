From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for May 17 (drivers/pwm/pwm-stm32.c)
Date: Thu, 17 May 2018 11:34:59 -0700
Message-ID: <b611bea0-d77b-7841-2127-277acda55747@infradead.org>
References: <20180517170656.1f746914@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517170656.1f746914@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gerald Baeza <gerald.baeza@st.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 05/17/2018 12:06 AM, Stephen Rothwell wrote:
> Hi all,
> 

on x86_64:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture':
pwm-stm32.c:(.text+0x53d): undefined reference to `stm32_timers_dma_burst_read'

when COMPILE_TEST=y and MFD_STM32_TIMERS is not set.


Any suggestions?

thanks,
-- 
~Randy
