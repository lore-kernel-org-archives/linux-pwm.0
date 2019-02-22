From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Fri, 22 Feb 2019 10:41:37 -0600
Message-ID: <20190222164137.GA23340@bogus>
References: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
 <1550740301-10097-2-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550740301-10097-2-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com, Yash Shah <yash.shah@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 21 Feb 2019 14:41:40 +0530, Yash Shah wrote:
> DT documentation for PWM controller added.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
