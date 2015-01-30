From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 11:08:46 +0000
Message-ID: <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug@mail.gmail.com>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
	<54BE3369.9000802@imgtec.com>
	<54CA6089.50505@imgtec.com>
	<20150130091832.GA16744@ulmo>
	<CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
	<20150130102612.GE16744@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150130102612.GE16744@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

+linux-mips

On Fri, Jan 30, 2015 at 10:26 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Jan 30, 2015 at 09:50:46AM +0000, Andrew Bresticker wrote:
>> > Also you're making it especially difficult to build-test by not
>> > providing even the basic bits of your SoC support first. All even
>> > linux-next seems to have for the Pistachio SoC is the addition of a
>> > compatible string to the dw-mmc driver.
>> >
>> > I'll take the PWM driver, but I'll assume that you'll eventually have
>> > more pieces available, in which case I'd appreciate a note so I can
>> > update my build scripts.
>>
>> FYI, I'm hoping to post Pistachio platform support for 3.21.
>
> That'd be great. I can switch over to a proper defconfig then and not
> jump through extra hoops to build test patches.
>
> Also, I'm seeing a bunch of weird errors from building MIPS, mostly
> things like this:
>
>           CC      net/ipv4/netfilter/arp_tables.mod.o
>         {standard input}: Assembler messages:
>         {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>
> or this later on:
>
>         mips-linux-gnu-ld: Warning: vmlinuz uses -mhard-float (set by arch/mips/boot/compressed/head.o), arch/mips/boot/compressed/decompress.o uses -msoft-float
>
> This is essentially a gpr_defconfig (because it select MIPS_ALCHEMY,
> which in turns pulls in COMMON_CLK that PWM_IMG depends on) and then
> enabling MFD_SYSCON on top so that all dependencies are met.
>
> What am I doing wrong?

What version of binutils are you using?  I believe the latter error
should be fixed by commit 842dfc11ea9a ("MIPS: Fix build with binutils
2.24.51+"), but perhaps the decompressor Makefile requires a fix as
well?  Unfortunately I'm traveling for the next couple of days, but I
may be able to take a look at it on Monday.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
