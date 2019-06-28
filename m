Return-Path: <logang@deltatee.com>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <8ac86487399c5cfa180f3d6dad5de944a40c3520.1561724493.git.mchehab+samsung@kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3f2b9e1e-7ae7-aa1e-ce8c-ff20cc2b70bd@deltatee.com>
Date: Fri, 28 Jun 2019 10:38:16 -0600
MIME-Version: 1.0
In-Reply-To: <8ac86487399c5cfa180f3d6dad5de944a40c3520.1561724493.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 29/39] docs: driver-api: add a series of orphaned
 documents
List-ID: <linux-pwm.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Johannes Berg <johannes@sipsolutions.net>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Johannes Thumshirn <morbidrsa@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, Gustavo Padovan <gustavo@padovan.org>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Evgeniy Polyakov <zbr@ioremap.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org



On 2019-06-28 6:30 a.m., Mauro Carvalho Chehab wrote:
> There are lots of documents under Documentation/*.txt and a few other
> orphan documents elsehwere that belong to the driver-API book.
> 
> Move them to their right place.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

For the switchtec changes:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan


> ---
>  Documentation/ABI/removed/sysfs-class-rfkill  |  2 +-
>  Documentation/ABI/stable/sysfs-class-rfkill   |  2 +-
>  .../ABI/testing/sysfs-class-switchtec         |  2 +-
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  .../admin-guide/laptops/thinkpad-acpi.rst     |  6 ++---
>  .../bt8xxgpio.rst}                            |  0
>  .../{connector => driver-api}/connector.rst   |  2 +-
>  .../{console => driver-api}/console.rst       |  2 +-
>  .../{dcdbas.txt => driver-api/dcdbas.rst}     |  0
>  .../{dell_rbu.txt => driver-api/dell_rbu.rst} |  0
>  .../{EDID/howto.rst => driver-api/edid.rst}   |  2 +-
>  .../{eisa.txt => driver-api/eisa.rst}         |  0
>  Documentation/driver-api/index.rst            | 26 +++++++++++++++++++
>  Documentation/{isa.txt => driver-api/isa.rst} |  0
>  .../{isapnp.txt => driver-api/isapnp.rst}     |  0
>  .../pblk.txt => driver-api/lightnvm-pblk.rst} |  0
>  .../men-chameleon-bus.rst}                    |  0
>  Documentation/{ntb.txt => driver-api/ntb.rst} |  0
>  Documentation/{nvmem => driver-api}/nvmem.rst |  2 +-
>  .../parport-lowlevel.rst}                     |  0
>  .../{pti => driver-api}/pti_intel_mid.rst     |  2 +-
>  Documentation/{pwm.txt => driver-api/pwm.rst} |  0
>  .../{rfkill.txt => driver-api/rfkill.rst}     |  0
>  .../{sgi-ioc4.txt => driver-api/sgi-ioc4.rst} |  0
>  .../{SM501.txt => driver-api/sm501.rst}       |  0
>  .../smsc_ece1099.rst}                         |  0
>  .../switchtec.rst}                            |  2 +-
>  .../sync_file.rst}                            |  0
>  .../vfio-mediated-device.rst}                 |  2 +-
>  .../{vfio.txt => driver-api/vfio.rst}         |  0
>  .../{xillybus.txt => driver-api/xillybus.rst} |  0
>  .../{zorro.txt => driver-api/zorro.rst}       |  0
>  Documentation/fb/fbcon.rst                    |  4 +--
>  Documentation/s390/vfio-ccw.rst               |  6 ++---
>  Documentation/w1/w1.netlink                   |  2 +-
>  MAINTAINERS                                   | 22 ++++++++--------
>  Next/merge.log                                |  4 +--
>  drivers/dma-buf/Kconfig                       |  2 +-
>  drivers/gpio/Kconfig                          |  2 +-
>  drivers/gpu/drm/Kconfig                       |  2 +-
>  drivers/pci/switch/Kconfig                    |  2 +-
>  drivers/platform/x86/Kconfig                  |  4 +--
>  drivers/platform/x86/dcdbas.c                 |  2 +-
>  drivers/platform/x86/dell_rbu.c               |  2 +-
>  drivers/pnp/isapnp/Kconfig                    |  2 +-
>  drivers/tty/Kconfig                           |  2 +-
>  drivers/vfio/Kconfig                          |  2 +-
>  drivers/vfio/mdev/Kconfig                     |  2 +-
>  drivers/w1/Kconfig                            |  2 +-
>  samples/Kconfig                               |  2 +-
>  50 files changed, 73 insertions(+), 47 deletions(-)
>  rename Documentation/{bt8xxgpio.txt => driver-api/bt8xxgpio.rst} (100%)
>  rename Documentation/{connector => driver-api}/connector.rst (99%)
>  rename Documentation/{console => driver-api}/console.rst (99%)
>  rename Documentation/{dcdbas.txt => driver-api/dcdbas.rst} (100%)
>  rename Documentation/{dell_rbu.txt => driver-api/dell_rbu.rst} (100%)
>  rename Documentation/{EDID/howto.rst => driver-api/edid.rst} (98%)
>  rename Documentation/{eisa.txt => driver-api/eisa.rst} (100%)
>  rename Documentation/{isa.txt => driver-api/isa.rst} (100%)
>  rename Documentation/{isapnp.txt => driver-api/isapnp.rst} (100%)
>  rename Documentation/{lightnvm/pblk.txt => driver-api/lightnvm-pblk.rst} (100%)
>  rename Documentation/{men-chameleon-bus.txt => driver-api/men-chameleon-bus.rst} (100%)
>  rename Documentation/{ntb.txt => driver-api/ntb.rst} (100%)
>  rename Documentation/{nvmem => driver-api}/nvmem.rst (99%)
>  rename Documentation/{parport-lowlevel.txt => driver-api/parport-lowlevel.rst} (100%)
>  rename Documentation/{pti => driver-api}/pti_intel_mid.rst (99%)
>  rename Documentation/{pwm.txt => driver-api/pwm.rst} (100%)
>  rename Documentation/{rfkill.txt => driver-api/rfkill.rst} (100%)
>  rename Documentation/{sgi-ioc4.txt => driver-api/sgi-ioc4.rst} (100%)
>  rename Documentation/{SM501.txt => driver-api/sm501.rst} (100%)
>  rename Documentation/{smsc_ece1099.txt => driver-api/smsc_ece1099.rst} (100%)
>  rename Documentation/{switchtec.txt => driver-api/switchtec.rst} (97%)
>  rename Documentation/{sync_file.txt => driver-api/sync_file.rst} (100%)
>  rename Documentation/{vfio-mediated-device.txt => driver-api/vfio-mediated-device.rst} (99%)
>  rename Documentation/{vfio.txt => driver-api/vfio.rst} (100%)
>  rename Documentation/{xillybus.txt => driver-api/xillybus.rst} (100%)
>  rename Documentation/{zorro.txt => driver-api/zorro.rst} (100%)
> 
> diff --git a/Documentation/ABI/removed/sysfs-class-rfkill b/Documentation/ABI/removed/sysfs-class-rfkill
> index 3ce6231f20b2..9c08c7f98ffb 100644
> --- a/Documentation/ABI/removed/sysfs-class-rfkill
> +++ b/Documentation/ABI/removed/sysfs-class-rfkill
> @@ -1,6 +1,6 @@
>  rfkill - radio frequency (RF) connector kill switch support
>  
> -For details to this subsystem look at Documentation/rfkill.txt.
> +For details to this subsystem look at Documentation/driver-api/rfkill.rst.
>  
>  What:		/sys/class/rfkill/rfkill[0-9]+/claim
>  Date:		09-Jul-2007
> diff --git a/Documentation/ABI/stable/sysfs-class-rfkill b/Documentation/ABI/stable/sysfs-class-rfkill
> index 80151a409d67..5b154f922643 100644
> --- a/Documentation/ABI/stable/sysfs-class-rfkill
> +++ b/Documentation/ABI/stable/sysfs-class-rfkill
> @@ -1,6 +1,6 @@
>  rfkill - radio frequency (RF) connector kill switch support
>  
> -For details to this subsystem look at Documentation/rfkill.txt.
> +For details to this subsystem look at Documentation/driver-api/rfkill.rst.
>  
>  For the deprecated /sys/class/rfkill/*/claim knobs of this interface look in
>  Documentation/ABI/removed/sysfs-class-rfkill.
> diff --git a/Documentation/ABI/testing/sysfs-class-switchtec b/Documentation/ABI/testing/sysfs-class-switchtec
> index 48cb4c15e430..76c7a661a595 100644
> --- a/Documentation/ABI/testing/sysfs-class-switchtec
> +++ b/Documentation/ABI/testing/sysfs-class-switchtec
> @@ -1,6 +1,6 @@
>  switchtec - Microsemi Switchtec PCI Switch Management Endpoint
>  
> -For details on this subsystem look at Documentation/switchtec.txt.
> +For details on this subsystem look at Documentation/driver-api/switchtec.rst.
>  
>  What: 		/sys/class/switchtec
>  Date:		05-Jan-2017
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 713d6f378fbe..de1c40167a26 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -930,7 +930,7 @@
>  			edid/1680x1050.bin, or edid/1920x1080.bin is given
>  			and no file with the same name exists. Details and
>  			instructions how to build your own EDID data are
> -			available in Documentation/EDID/howto.rst. An EDID
> +			available in Documentation/driver-api/edid.rst. An EDID
>  			data set will only be used for a particular connector,
>  			if its name and a colon are prepended to the EDID
>  			name. Each connector may use a unique EDID data
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> index 19d52fc3c5e9..adea0bf2acc5 100644
> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> @@ -643,7 +643,7 @@ Sysfs notes
>  	2010.
>  
>  	rfkill controller switch "tpacpi_bluetooth_sw": refer to
> -	Documentation/rfkill.txt for details.
> +	Documentation/driver-api/rfkill.rst for details.
>  
>  
>  Video output control -- /proc/acpi/ibm/video
> @@ -1406,7 +1406,7 @@ Sysfs notes
>  	2010.
>  
>  	rfkill controller switch "tpacpi_wwan_sw": refer to
> -	Documentation/rfkill.txt for details.
> +	Documentation/driver-api/rfkill.rst for details.
>  
>  
>  EXPERIMENTAL: UWB
> @@ -1426,7 +1426,7 @@ Sysfs notes
>  ^^^^^^^^^^^
>  
>  	rfkill controller switch "tpacpi_uwb_sw": refer to
> -	Documentation/rfkill.txt for details.
> +	Documentation/driver-api/rfkill.rst for details.
>  
>  Adaptive keyboard
>  -----------------
> diff --git a/Documentation/bt8xxgpio.txt b/Documentation/driver-api/bt8xxgpio.rst
> similarity index 100%
> rename from Documentation/bt8xxgpio.txt
> rename to Documentation/driver-api/bt8xxgpio.rst
> diff --git a/Documentation/connector/connector.rst b/Documentation/driver-api/connector.rst
> similarity index 99%
> rename from Documentation/connector/connector.rst
> rename to Documentation/driver-api/connector.rst
> index 24e26dc22dbf..c100c7482289 100644
> --- a/Documentation/connector/connector.rst
> +++ b/Documentation/driver-api/connector.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ================
>  Kernel Connector
> diff --git a/Documentation/console/console.rst b/Documentation/driver-api/console.rst
> similarity index 99%
> rename from Documentation/console/console.rst
> rename to Documentation/driver-api/console.rst
> index b374141b027e..8394ad7747ac 100644
> --- a/Documentation/console/console.rst
> +++ b/Documentation/driver-api/console.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ===============
>  Console Drivers
> diff --git a/Documentation/dcdbas.txt b/Documentation/driver-api/dcdbas.rst
> similarity index 100%
> rename from Documentation/dcdbas.txt
> rename to Documentation/driver-api/dcdbas.rst
> diff --git a/Documentation/dell_rbu.txt b/Documentation/driver-api/dell_rbu.rst
> similarity index 100%
> rename from Documentation/dell_rbu.txt
> rename to Documentation/driver-api/dell_rbu.rst
> diff --git a/Documentation/EDID/howto.rst b/Documentation/driver-api/edid.rst
> similarity index 98%
> rename from Documentation/EDID/howto.rst
> rename to Documentation/driver-api/edid.rst
> index 725fd49a88ca..b1b5acd501ed 100644
> --- a/Documentation/EDID/howto.rst
> +++ b/Documentation/driver-api/edid.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ====
>  EDID
> diff --git a/Documentation/eisa.txt b/Documentation/driver-api/eisa.rst
> similarity index 100%
> rename from Documentation/eisa.txt
> rename to Documentation/driver-api/eisa.rst
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 93d187bf4853..bba01cb95162 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -68,7 +68,33 @@ available subsections can be seen below.
>     fpga/index
>     acpi/index
>     backlight/lp855x-driver.rst
> +   bt8xxgpio
> +   connector
> +   console
> +   dcdbas
> +   dell_rbu
> +   edid
> +   eisa
> +   isa
> +   isapnp
>     generic-counter
> +   lightnvm-pblk
> +   men-chameleon-bus
> +   ntb
> +   nvmem
> +   parport-lowlevel
> +   pti_intel_mid
> +   pwm
> +   rfkill
> +   sgi-ioc4
> +   sm501
> +   smsc_ece1099
> +   switchtec
> +   sync_file
> +   vfio-mediated-device
> +   vfio
> +   xillybus
> +   zorro
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/isa.txt b/Documentation/driver-api/isa.rst
> similarity index 100%
> rename from Documentation/isa.txt
> rename to Documentation/driver-api/isa.rst
> diff --git a/Documentation/isapnp.txt b/Documentation/driver-api/isapnp.rst
> similarity index 100%
> rename from Documentation/isapnp.txt
> rename to Documentation/driver-api/isapnp.rst
> diff --git a/Documentation/lightnvm/pblk.txt b/Documentation/driver-api/lightnvm-pblk.rst
> similarity index 100%
> rename from Documentation/lightnvm/pblk.txt
> rename to Documentation/driver-api/lightnvm-pblk.rst
> diff --git a/Documentation/men-chameleon-bus.txt b/Documentation/driver-api/men-chameleon-bus.rst
> similarity index 100%
> rename from Documentation/men-chameleon-bus.txt
> rename to Documentation/driver-api/men-chameleon-bus.rst
> diff --git a/Documentation/ntb.txt b/Documentation/driver-api/ntb.rst
> similarity index 100%
> rename from Documentation/ntb.txt
> rename to Documentation/driver-api/ntb.rst
> diff --git a/Documentation/nvmem/nvmem.rst b/Documentation/driver-api/nvmem.rst
> similarity index 99%
> rename from Documentation/nvmem/nvmem.rst
> rename to Documentation/driver-api/nvmem.rst
> index 3866b6e066d5..d9d958d5c824 100644
> --- a/Documentation/nvmem/nvmem.rst
> +++ b/Documentation/driver-api/nvmem.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ===============
>  NVMEM Subsystem
> diff --git a/Documentation/parport-lowlevel.txt b/Documentation/driver-api/parport-lowlevel.rst
> similarity index 100%
> rename from Documentation/parport-lowlevel.txt
> rename to Documentation/driver-api/parport-lowlevel.rst
> diff --git a/Documentation/pti/pti_intel_mid.rst b/Documentation/driver-api/pti_intel_mid.rst
> similarity index 99%
> rename from Documentation/pti/pti_intel_mid.rst
> rename to Documentation/driver-api/pti_intel_mid.rst
> index ea05725174cb..20f1cff42d5f 100644
> --- a/Documentation/pti/pti_intel_mid.rst
> +++ b/Documentation/driver-api/pti_intel_mid.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  =============
>  Intel MID PTI
> diff --git a/Documentation/pwm.txt b/Documentation/driver-api/pwm.rst
> similarity index 100%
> rename from Documentation/pwm.txt
> rename to Documentation/driver-api/pwm.rst
> diff --git a/Documentation/rfkill.txt b/Documentation/driver-api/rfkill.rst
> similarity index 100%
> rename from Documentation/rfkill.txt
> rename to Documentation/driver-api/rfkill.rst
> diff --git a/Documentation/sgi-ioc4.txt b/Documentation/driver-api/sgi-ioc4.rst
> similarity index 100%
> rename from Documentation/sgi-ioc4.txt
> rename to Documentation/driver-api/sgi-ioc4.rst
> diff --git a/Documentation/SM501.txt b/Documentation/driver-api/sm501.rst
> similarity index 100%
> rename from Documentation/SM501.txt
> rename to Documentation/driver-api/sm501.rst
> diff --git a/Documentation/smsc_ece1099.txt b/Documentation/driver-api/smsc_ece1099.rst
> similarity index 100%
> rename from Documentation/smsc_ece1099.txt
> rename to Documentation/driver-api/smsc_ece1099.rst
> diff --git a/Documentation/switchtec.txt b/Documentation/driver-api/switchtec.rst
> similarity index 97%
> rename from Documentation/switchtec.txt
> rename to Documentation/driver-api/switchtec.rst
> index 30d6a64e53f7..7611fdc53e19 100644
> --- a/Documentation/switchtec.txt
> +++ b/Documentation/driver-api/switchtec.rst
> @@ -97,6 +97,6 @@ the following configuration settings:
>  NT EP BAR 2 will be dynamically configured as a Direct Window, and
>  the configuration file does not need to configure it explicitly.
>  
> -Please refer to Documentation/ntb.txt in Linux source tree for an overall
> +Please refer to Documentation/driver-api/ntb.rst in Linux source tree for an overall
>  understanding of the Linux NTB stack. ntb_hw_switchtec works as an NTB
>  Hardware Driver in this stack.
> diff --git a/Documentation/sync_file.txt b/Documentation/driver-api/sync_file.rst
> similarity index 100%
> rename from Documentation/sync_file.txt
> rename to Documentation/driver-api/sync_file.rst
> diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/driver-api/vfio-mediated-device.rst
> similarity index 99%
> rename from Documentation/vfio-mediated-device.txt
> rename to Documentation/driver-api/vfio-mediated-device.rst
> index c3f69bcaf96e..25eb7d5b834b 100644
> --- a/Documentation/vfio-mediated-device.txt
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -408,7 +408,7 @@ card.
>  References
>  ==========
>  
> -1. See Documentation/vfio.txt for more information on VFIO.
> +1. See Documentation/driver-api/vfio.rst for more information on VFIO.
>  2. struct mdev_driver in include/linux/mdev.h
>  3. struct mdev_parent_ops in include/linux/mdev.h
>  4. struct vfio_iommu_driver_ops in include/linux/vfio.h
> diff --git a/Documentation/vfio.txt b/Documentation/driver-api/vfio.rst
> similarity index 100%
> rename from Documentation/vfio.txt
> rename to Documentation/driver-api/vfio.rst
> diff --git a/Documentation/xillybus.txt b/Documentation/driver-api/xillybus.rst
> similarity index 100%
> rename from Documentation/xillybus.txt
> rename to Documentation/driver-api/xillybus.rst
> diff --git a/Documentation/zorro.txt b/Documentation/driver-api/zorro.rst
> similarity index 100%
> rename from Documentation/zorro.txt
> rename to Documentation/driver-api/zorro.rst
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index 26bc5cdaabab..ebca41785abe 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -187,7 +187,7 @@ the hardware. Thus, in a VGA console::
>  Assuming the VGA driver can be unloaded, one must first unbind the VGA driver
>  from the console layer before unloading the driver.  The VGA driver cannot be
>  unloaded if it is still bound to the console layer. (See
> -Documentation/console/console.rst for more information).
> +Documentation/driver-api/console.rst for more information).
>  
>  This is more complicated in the case of the framebuffer console (fbcon),
>  because fbcon is an intermediate layer between the console and the drivers::
> @@ -204,7 +204,7 @@ fbcon. Thus, there is no need to explicitly unbind the fbdev drivers from
>  fbcon.
>  
>  So, how do we unbind fbcon from the console? Part of the answer is in
> -Documentation/console/console.rst. To summarize:
> +Documentation/driver-api/console.rst. To summarize:
>  
>  Echo a value to the bind file that represents the framebuffer console
>  driver. So assuming vtcon1 represents fbcon, then::
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index 1f6d0b56d53e..1e210c6afa88 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -38,7 +38,7 @@ every detail. More information/reference could be found here:
>    qemu/hw/s390x/css.c
>  
>  For vfio mediated device framework:
> -- Documentation/vfio-mediated-device.txt
> +- Documentation/driver-api/vfio-mediated-device.rst
>  
>  Motivation of vfio-ccw
>  ----------------------
> @@ -322,5 +322,5 @@ Reference
>  2. ESA/390 Common I/O Device Commands manual (IBM Form. No. SA22-7204)
>  3. https://en.wikipedia.org/wiki/Channel_I/O
>  4. Documentation/s390/cds.rst
> -5. Documentation/vfio.txt
> -6. Documentation/vfio-mediated-device.txt
> +5. Documentation/driver-api/vfio.rst
> +6. Documentation/driver-api/vfio-mediated-device.rst
> diff --git a/Documentation/w1/w1.netlink b/Documentation/w1/w1.netlink
> index ef2727192d69..94ad4c420828 100644
> --- a/Documentation/w1/w1.netlink
> +++ b/Documentation/w1/w1.netlink
> @@ -183,7 +183,7 @@ acknowledge number is set to seq+1.
>  Additional documantion, source code examples.
>  ============================================
>  
> -1. Documentation/connector
> +1. Documentation/driver-api/connector.rst
>  2. http://www.ioremap.net/archive/w1
>  This archive includes userspace application w1d.c which uses
>  read/write/search commands for all master/slave devices found on the bus.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b52a20663e..055db86fdd77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4603,7 +4603,7 @@ DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
>  M:	Stuart Hayes <stuart.w.hayes@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/dcdbas.txt
> +F:	Documentation/driver-api/dcdbas.rst
>  F:	drivers/platform/x86/dcdbas.*
>  
>  DELL WMI NOTIFICATIONS DRIVER
> @@ -8409,7 +8409,7 @@ F:	drivers/irqchip/
>  ISA
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  S:	Maintained
> -F:	Documentation/isa.txt
> +F:	Documentation/driver-api/isa.rst
>  F:	drivers/base/isa.c
>  F:	include/linux/isa.h
>  
> @@ -8424,7 +8424,7 @@ F:	drivers/media/radio/radio-isa*
>  ISAPNP
>  M:	Jaroslav Kysela <perex@perex.cz>
>  S:	Maintained
> -F:	Documentation/isapnp.txt
> +F:	Documentation/driver-api/isapnp.rst
>  F:	drivers/pnp/isapnp/
>  F:	include/linux/isapnp.h
>  
> @@ -10309,7 +10309,7 @@ M:	Johannes Thumshirn <morbidrsa@gmail.com>
>  S:	Maintained
>  F:	drivers/mcb/
>  F:	include/linux/mcb.h
> -F:	Documentation/men-chameleon-bus.txt
> +F:	Documentation/driver-api/men-chameleon-bus.rst
>  
>  MEN F21BMC (Board Management Controller)
>  M:	Andreas Werner <andreas.werner@men.de>
> @@ -12012,7 +12012,7 @@ F:	drivers/parport/
>  F:	include/linux/parport*.h
>  F:	drivers/char/ppdev.c
>  F:	include/uapi/linux/ppdev.h
> -F:	Documentation/parport*.txt
> +F:	Documentation/driver-api/parport*.rst
>  
>  PARAVIRT_OPS INTERFACE
>  M:	Juergen Gross <jgross@suse.com>
> @@ -12187,7 +12187,7 @@ M:	Kurt Schwemmer <kurt.schwemmer@microsemi.com>
>  M:	Logan Gunthorpe <logang@deltatee.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/switchtec.txt
> +F:	Documentation/driver-api/switchtec.rst
>  F:	Documentation/ABI/testing/sysfs-class-switchtec
>  F:	drivers/pci/switch/switchtec*
>  F:	include/uapi/linux/switchtec_ioctl.h
> @@ -12949,7 +12949,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> -F:	Documentation/pwm.txt
> +F:	Documentation/driver-api/pwm.rst
>  F:	Documentation/devicetree/bindings/pwm/
>  F:	include/linux/pwm.h
>  F:	drivers/pwm/
> @@ -13568,7 +13568,7 @@ W:	http://wireless.kernel.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
>  S:	Maintained
> -F:	Documentation/rfkill.txt
> +F:	Documentation/driver-api/rfkill.rst
>  F:	Documentation/ABI/stable/sysfs-class-rfkill
>  F:	net/rfkill/
>  F:	include/linux/rfkill.h
> @@ -15285,7 +15285,7 @@ F:	drivers/dma-buf/dma-fence*
>  F:	drivers/dma-buf/sw_sync.c
>  F:	include/linux/sync_file.h
>  F:	include/uapi/linux/sync_file.h
> -F:	Documentation/sync_file.txt
> +F:	Documentation/driver-api/sync_file.rst
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  SYNOPSYS ARC ARCHITECTURE
> @@ -16781,7 +16781,7 @@ R:	Cornelia Huck <cohuck@redhat.com>
>  L:	kvm@vger.kernel.org
>  T:	git git://github.com/awilliam/linux-vfio.git
>  S:	Maintained
> -F:	Documentation/vfio.txt
> +F:	Documentation/driver-api/vfio.rst
>  F:	drivers/vfio/
>  F:	include/linux/vfio.h
>  F:	include/uapi/linux/vfio.h
> @@ -16790,7 +16790,7 @@ VFIO MEDIATED DEVICE DRIVERS
>  M:	Kirti Wankhede <kwankhede@nvidia.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/vfio-mediated-device.txt
> +F:	Documentation/driver-api/vfio-mediated-device.rst
>  F:	drivers/vfio/mdev/
>  F:	include/linux/mdev.h
>  F:	samples/vfio-mdev/
> diff --git a/Next/merge.log b/Next/merge.log
> index 2cb0ee66fa51..e9f5123f59ca 100644
> --- a/Next/merge.log
> +++ b/Next/merge.log
> @@ -13842,7 +13842,7 @@ Merge made by the 'recursive' strategy.
>   .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
>   .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |   9 +-
>   .../devicetree/bindings/pwm/pwm-stm32.txt          |   3 +
> - Documentation/pwm.txt                              |   7 +
> + Documentation/driver-api/pwm.rst                              |   7 +
>   drivers/leds/leds-pwm.c                            |  45 ++-
>   drivers/pwm/Kconfig                                |  11 +
>   drivers/pwm/Makefile                               |   1 +
> @@ -14162,7 +14162,7 @@ Auto-merging drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>  Auto-merging drivers/ntb/Makefile
>  Auto-merging drivers/ntb/Kconfig
>  Merge made by the 'recursive' strategy.
> - Documentation/ntb.txt                   |  27 ++
> + Documentation/driver-api/ntb.rst                   |  27 ++
>   drivers/ntb/Kconfig                     |  11 +
>   drivers/ntb/Makefile                    |   3 +
>   drivers/ntb/{ntb.c => core.c}           |   0
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index d5f915830b68..b6a9c2f1bc41 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -15,7 +15,7 @@ config SYNC_FILE
>  	  associated with a buffer. When a job is submitted to the GPU a fence
>  	  is attached to the buffer and is transferred via userspace, using Sync
>  	  Files fds, to the DRM driver for example. More details at
> -	  Documentation/sync_file.txt.
> +	  Documentation/driver-api/sync_file.rst.
>  
>  config SW_SYNC
>  	bool "Sync File Validation Framework"
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c377c989000c..49f04621279c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1300,7 +1300,7 @@ config GPIO_BT8XX
>  	  The card needs to be physically altered for using it as a
>  	  GPIO card. For more information on how to build a GPIO card
>  	  from a BT8xx TV card, see the documentation file at
> -	  Documentation/bt8xxgpio.txt
> +	  Documentation/driver-api/bt8xxgpio.rst
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index ee01afbbcd90..503a907d5ae5 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -141,7 +141,7 @@ config DRM_LOAD_EDID_FIRMWARE
>  	  monitor are unable to provide appropriate EDID data. Since this
>  	  feature is provided as a workaround for broken hardware, the
>  	  default case is N. Details and instructions how to build your own
> -	  EDID data are given in Documentation/EDID/howto.rst.
> +	  EDID data are given in Documentation/driver-api/edid.rst.
>  
>  config DRM_DP_CEC
>  	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
> diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
> index aee28a5bb98f..d370f4ce0492 100644
> --- a/drivers/pci/switch/Kconfig
> +++ b/drivers/pci/switch/Kconfig
> @@ -9,7 +9,7 @@ config PCI_SW_SWITCHTEC
>  	 Enables support for the management interface for the MicroSemi
>  	 Switchtec series of PCIe switches. Supports userspace access
>  	 to submit MRPC commands to the switch via /dev/switchtecX
> -	 devices. See <file:Documentation/switchtec.txt> for more
> +	 devices. See <file:Documentation/driver-api/switchtec.rst> for more
>  	 information.
>  
>  endmenu
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 85101c678693..e09aa0087024 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -118,7 +118,7 @@ config DCDBAS
>  	  Interrupts (SMIs) and Host Control Actions (system power cycle or
>  	  power off after OS shutdown) on certain Dell systems.
>  
> -	  See <file:Documentation/dcdbas.txt> for more details on the driver
> +	  See <file:Documentation/driver-api/dcdbas.rst> for more details on the driver
>  	  and the Dell systems on which Dell systems management software makes
>  	  use of this driver.
>  
> @@ -259,7 +259,7 @@ config DELL_RBU
>  	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
>  	 supporting application to communicate with the BIOS regarding the new
>  	 image for the image update to take effect.
> -	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
> +	 See <file:Documentation/driver-api/dell_rbu.rst> for more details on the driver.
>  
>  
>  config FUJITSU_LAPTOP
> diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dcdbas.c
> index 12cf9475ac85..84f4cc839cc3 100644
> --- a/drivers/platform/x86/dcdbas.c
> +++ b/drivers/platform/x86/dcdbas.c
> @@ -7,7 +7,7 @@
>   *  and Host Control Actions (power cycle or power off after OS shutdown) on
>   *  Dell systems.
>   *
> - *  See Documentation/dcdbas.txt for more information.
> + *  See Documentation/driver-api/dcdbas.rst for more information.
>   *
>   *  Copyright (C) 1995-2006 Dell Inc.
>   */
> diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
> index a58fc10293ee..3691391fea6b 100644
> --- a/drivers/platform/x86/dell_rbu.c
> +++ b/drivers/platform/x86/dell_rbu.c
> @@ -24,7 +24,7 @@
>   * on every time the packet data is written. This driver requires an
>   * application to break the BIOS image in to fixed sized packet chunks.
>   *
> - * See Documentation/dell_rbu.txt for more info.
> + * See Documentation/driver-api/dell_rbu.rst for more info.
>   */
>  #include <linux/init.h>
>  #include <linux/module.h>
> diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> index 4b58a3dcb52b..d0479a563123 100644
> --- a/drivers/pnp/isapnp/Kconfig
> +++ b/drivers/pnp/isapnp/Kconfig
> @@ -7,6 +7,6 @@ config ISAPNP
>  	depends on ISA || COMPILE_TEST
>  	help
>  	  Say Y here if you would like support for ISA Plug and Play devices.
> -	  Some information is in <file:Documentation/isapnp.txt>.
> +	  Some information is in <file:Documentation/driver-api/isapnp.rst>.
>  
>  	  If unsure, say Y.
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 1cb50f19d58c..ee51b9514225 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -93,7 +93,7 @@ config VT_HW_CONSOLE_BINDING
>           select the console driver that will serve as the backend for the
>           virtual terminals.
>  
> -	 See <file:Documentation/console/console.rst> for more
> +	 See <file:Documentation/driver-api/console.rst> for more
>  	 information. For framebuffer console users, please refer to
>  	 <file:Documentation/fb/fbcon.rst>.
>  
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index e5a7a454fe17..fd17db9b432f 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -25,7 +25,7 @@ menuconfig VFIO
>  	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM || ARM64)
>  	help
>  	  VFIO provides a framework for secure userspace device drivers.
> -	  See Documentation/vfio.txt for more details.
> +	  See Documentation/driver-api/vfio.rst for more details.
>  
>  	  If you don't know what to do here, say N.
>  
> diff --git a/drivers/vfio/mdev/Kconfig b/drivers/vfio/mdev/Kconfig
> index ba94a076887f..5da27f2100f9 100644
> --- a/drivers/vfio/mdev/Kconfig
> +++ b/drivers/vfio/mdev/Kconfig
> @@ -6,7 +6,7 @@ config VFIO_MDEV
>  	default n
>  	help
>  	  Provides a framework to virtualize devices.
> -	  See Documentation/vfio-mediated-device.txt for more details.
> +	  See Documentation/driver-api/vfio-mediated-device.rst for more details.
>  
>  	  If you don't know what do here, say N.
>  
> diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
> index 160053c0baea..3e7ad7b232fe 100644
> --- a/drivers/w1/Kconfig
> +++ b/drivers/w1/Kconfig
> @@ -19,7 +19,7 @@ config W1_CON
>  	default y
>  	---help---
>  	  This allows to communicate with userspace using connector. For more
> -	  information see <file:Documentation/connector/connector.rst>.
> +	  information see <file:Documentation/driver-api/connector.rst>.
>  	  There are three types of messages between w1 core and userspace:
>  	  1. Events. They are generated each time new master or slave device found
>  		either due to automatic or requested search.
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 155da47dc6a4..c8dacb4dda80 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -99,7 +99,7 @@ config SAMPLE_CONNECTOR
>  	  When enabled, this builds both a sample kernel module for
>  	  the connector interface and a user space tool to communicate
>  	  with it.
> -	  See also Documentation/connector/connector.rst
> +	  See also Documentation/driver-api/connector.rst
>  
>  config SAMPLE_HIDRAW
>  	bool "hidraw sample"
> 
