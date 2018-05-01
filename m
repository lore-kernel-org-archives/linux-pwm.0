From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
Date: Tue, 01 May 2018 09:32:43 -0700 (PDT)
Message-ID: <mhng-4b69ea58-ea7d-458d-888d-de39bf0bd58b@palmer-si-x1c4>
References: <20180501161439.GA28644@rob-hp-laptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501161439.GA28644@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: Wesley Terpstra <wesley@sifive.com>, afaerber@suse.de, thierry.reding@gmail.com, mark.rutland@arm.com, noralf@tronnes.org, david@lechnology.com, alexandre.belloni@free-electrons.com, sz.lin@moxa.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 01 May 2018 09:14:39 PDT (-0700), robh@kernel.org wrote:
> On Sat, Apr 28, 2018 at 10:37:56PM +0000, Wesley Terpstra wrote:
>> Will do, thanks!
>
> Don't top post to lists.
>
> I've applied this. I assume you'll have things other than the PWM...

Thanks!

We have a handful of out-of-tree drivers for our current SOC (UART, GPIO, two 
clocks, SPI, I2C) that we plan on submitting upstream as time permits.
