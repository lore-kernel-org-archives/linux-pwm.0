From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Date: Thu, 23 Jul 2020 09:42:09 -0600
Message-ID: <20200723154209.GA423699@bogus>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <4e975206fcbddedc746e8d39b620336d5fab8b14.1595489518.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e975206fcbddedc746e8d39b620336d5fab8b14.1595489518.git.rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rahul.tanwar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 23 Jul 2020 15:44:17 +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dt.yaml: pwm@e0d00000: '#pwm-cells' is a required property


See https://patchwork.ozlabs.org/patch/1334579

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
