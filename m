From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Date: Mon, 29 Jun 2020 16:08:12 -0600
Message-ID: <20200629220812.GA3028453@bogus>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
 <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-il1-f193.google.com ([209.85.166.193]:38847 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgF2WIR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 18:08:17 -0400
Content-Disposition: inline
In-Reply-To: <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, songjun.Wu@intel.com, rahul.tanwar.linux@gmail.com, robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org

On Mon, 29 Jun 2020 17:03:46 +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'


See https://patchwork.ozlabs.org/patch/1318996

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
