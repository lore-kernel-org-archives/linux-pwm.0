From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/7] Remove unneeded build directory traversals
Date: Wed, 15 Mar 2017 22:34:57 +0100
Message-ID: <CAK8P3a3JxkbEyJig3M=Df=W8KDbwZURmfs7YdMWHx_K+2LsEfQ@mail.gmail.com>
References: <20170315163730.17055-1-afd@ti.com> <CAK8P3a1XBUUtJHrzfTa3GRqh+beU+1MteQ0evB8Vvy5zABRbmw@mail.gmail.com>
 <59d8c3d4-1fdf-7f30-f78c-92ddc9028d36@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <59d8c3d4-1fdf-7f30-f78c-92ddc9028d36@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 15, 2017 at 10:15 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/15/2017 04:03 PM, Arnd Bergmann wrote:
>> On Wed, Mar 15, 2017 at 5:37 PM, Andrew F. Davis <afd@ti.com> wrote:
>>> Hello all,
>>>
>>> I was building a kernel for x86 and noticed Make still descended into
>>> directories like drivers/gpu/drm/hisilicon, this seems kind of odd given
>>> nothing will be built here. It looks to be due to some directories being
>>> included in obj-y unconditionally instead of only when the relevant
>>> CONFIG_ is set.
>>>
>>> These patches are split by subsystem in-case, for some reason, a file in
>>> a directory does need to be built, I believe I have checked for all
>>> instances of this, but a quick review from some maintainers would be nice.
>>
>> I didn't see anything wrong with the patches, and made sure that there
>> are no tristate symbols controlling the subdirectory for anything that
>> requires a built-in driver (which would cause a link failure).
>>
>> I'm not sure about drivers/lguest, which has some special magic
>> in its Makefile, it's possible that this now fails with CONFIG_LGUEST=m.
>>
>
> lguest and mmc are the strange ones, so I put them last in the series in
> case they did need to be dropped.
>
> lguest was supposed to have been taken from v1:
> https://lkml.org/lkml/2016/6/20/1086
> but it looks like it didn't so I re-introduced it for v3.
>
> mmc caught some 0-day build warnings but I never got to the bottom of them.

Ah, I see now what happened to mmc:

obj-$(subst m,y,$(CONFIG_MMC))  += host/
tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))   += tmio_mmc_dma.o
obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))        += sdhci-pci-data.o

with CONFIG_MMC=m, this will fail to build the built-in files in
drivers/mmc/host. I suppose this could be expressed in a different
way these days, but dropping the patch would be easier.

     Arnd
