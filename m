From: Andreas Schwab <schwab@suse.de>
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
Date: Wed, 10 Oct 2018 15:01:29 +0200
Message-ID: <mvmo9c22bx2.fsf@suse.de>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
        <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539111085-25502-5-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Tue, 9 Oct 2018 11:51:25 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org

On Okt 09 2018, Atish Patra <atish.patra@wdc.com> wrote:

> +static void sifive_set_ie(struct sifive_gpio *chip, unsigned int offset)
> +{
> +	unsigned long flags;
> +	unsigned int trigger;
> +
> +	raw_spin_lock_irqsave(&chip->lock, flags);
> +	trigger = (chip->enabled & BIT(offset)) ? chip->trigger[offset] : 0;

This should use test_bit instead.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
