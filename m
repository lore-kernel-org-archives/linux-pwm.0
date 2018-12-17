From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 0/9] extend PWM framework to support PWM modes
Date: Mon, 17 Dec 2018 14:03:07 +0000
Message-ID: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series extends PWM framework with PWM modes.

The current patch series add the following PWM modes:
- PWM mode normal
- PWM mode complementary
- PWM mode push-pull

In the following description PWMx_y refers to output y of PWM with ID x.

Normal mode - for PWM channels with one output; output waveforms looks like
this:
              __      __      __      __                                   =
     =20
    PWMx   __|  |____|  |____|  |____|  |__                                =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Since PWMs with more than one output per channel could be used as one
output PWM the normal mode is the default mode for all PWMs (if not specifi=
ed
otherwise).

Complementary mode - for PWM channels with two outputs; output waveforms
for a PWM channel in complementary mode looks line this:
              __      __      __      __                                   =
     =20
    PWMx_0 __|  |____|  |____|  |____|  |__                                =
     =20
           __    ____    ____    ____    __                                =
     =20
    PWMx_1   |__|    |__|    |__|    |__|                                  =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Push-pull mode - for PWM channels with two outputs; output waveforms for a
PWM channel in push-pull mode with normal polarity looks like this:
              __              __                                           =
      =20
    PWMx_0 __|  |____________|  |__________                                =
      =20
                      __              __                                   =
      =20
    PWMx_1 __________|  |____________|  |__                                =
      =20
             ^       ^       ^       ^                                     =
      =20

    If polarity is inversed:
           __    ____________    __________                                =
      =20
    PWMx_0   |__|            |__|                                          =
      =20
           __________    ____________    __                                =
      =20
    PWMx_1           |__|            |__|                                  =
      =20
             ^       ^       ^       ^                                     =
      =20

    Where '^' specifies the beginning of a period.
=20
The PWM working modes are per PWM channel registered as PWM's capabilities.
The driver registers itself to PWM core a get_caps() function, in
struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
If this function is not registered in driver's probe, a default function
will be used to retrieve PWM capabilities. Currently, the default
capabilities includes only PWM normal mode.

PWM state has been updated to keep PWM mode. PWM mode could be configured
via sysfs. pwm_apply_state() will do the preliminary validation for PWM mod=
e
to be applied.

In sysfs, user could get PWM modes by reading mode file of PWM device:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
total 0
-r--r--r-- 1 root root 4096 Oct 11 18:08 capture
-rw-r--r-- 1 root root 4096 Oct 11 18:14 duty_cycle
-rw-r--r-- 1 root root 4096 Oct 11 18:11 enable
-rw-r--r-- 1 root root 4096 Oct 11 18:14 mode
-rw-r--r-- 1 root root 4096 Oct 11 18:09 period
-rw-r--r-- 1 root root 4096 Oct 11 18:14 polarity
drwxr-xr-x 2 root root    0 Oct 11 18:08 power
-rw-r--r-- 1 root root 4096 Oct 11 18:08 uevent
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
normal complementary [push-pull]

The mode enclosed in bracket is the currently active mode.

The mode could be set, via sysfs, by writing to mode file one of the modes
displayed at read:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
[normal] complementary push-pull=20

The PWM push-pull mode could be usefull in applications like half bridge
converters (see [1], page 2126).

This series also add PWM modes support for Atmel/Microchip SoCs.

Thank you,
Claudiu Beznea

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Changes in v6:
- get rid of DT changes;
- get rid of get_default_caps member of struct pwm_chip;
- remove struct pwm_chip argument of pwm_get_caps(); caps are retrieved
  in the context of a PWM device and at this moment the chip should be vali=
d;
  also, get rid of chip->ops check in pwm_get_caps();
- rename pwm_mode_get_valid() function to pwm_get_default_modebit();
- rename mode member of struct pwm_caps to modes_msk;
- rename pwm_mode_valid() function to pwm_supports_mode() and rename
  its mode argument to modebit to emphasize what should be passed to it;
- rename pwm_mode_desc() to pwm_get_mode_name() and avoid returning "invali=
d"
  string; pwm_get_mode_name() is called only with a valid modebit;
- rename mode member of struct pwm_state to modebit to emphasize that it st=
ores
  a bitmask;
- use const arguments for pwm_get_default_modebit(), pwm_get_caps(),
  pwm_supports_mode() and get_caps() member of struct pwm_ops;
- change return type of pwm_ops::get_caps() to int;
- rename PWMC_MODE() macro to PWM_MODE_BIT();
- rename PWMC_MODE_<mode-name>_BIT enum members to PWM_MODE_<mode-name>;
- remove patches 2/9, 3/9, 4/9 from previous version since they were relate=
d
  to DT changes;
- use PWMx_y naming in documentation to emphasize it is talked about output
  y of PWM x;
- use 1/3 duty factor in waveforms from documentation patches;
- use '^' to emphasize the beginning of a new period in documentation patch=
es.

Changes in v5:
- solved kbuild errors by removing dummy functions for case where
  CONFIG_PWM is not defined; adopted this approach since the removed
  function are used only when CONFIG_PWM is defined (in PWM core
  and few drivers from drivers/pwm/ directory)

Changes in v4:
- removed changes related to pwm_config() as per maintainer proposals
- added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
  instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
  pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
  (patches 2, 3, 4 from this series)
- renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
  pwm-sun4i.c driver ('C' stands for capability)
- removed pwm_caps_valid() function
- renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
  PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL

Changes in v3:
- removed changes related to only one of_xlate function for all PWM drivers
- switch to PWM capabilities per PWM channel nor per PWM chip
- squash documentation and bindings patches as requeted by reviewer
- introduced PWM_MODE(name) macro and used a bit enum for pwm modes
- related to DT bindings, used flags cell also for PWM modes
- updated of_xlate specific functions with "state->mode =3D mode;"
  instructions to avoid pwm_apply_state() failures
- use available modes for PWM channel in pwm_config() by first calling
  pwm_get_caps() to get caps.modes
- use loops through available modes in mode_store()/mode_show() and also in
  of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
  the addition of a new mode is independent of this code sections
- use DTLI=3D1, DTHI=3D0 register settings to obtain push-pull mode wavefor=
ms
  for Atmel/Microchip PWM controller.

Changes in v2:
- remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
  inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this =
will
  make easy the addition of PWM mode support from DT
- add PWM mode normal
- register PWM modes as capabilities of PWM chips at driver probe and, in c=
ase
  driver doesn't provide these capabilities use default ones
- change the way PWM mode is pharsed via DT by using a new input for pwms
  binding property


Claudiu Beznea (9):
  pwm: extend PWM framework with PWM modes
  pwm: clps711x: populate PWM mode in of_xlate function
  pwm: cros-ec: populate PWM mode in of_xlate function
  pwm: pxa: populate PWM mode in of_xlate function
  pwm: add PWM modes
  pwm: atmel: add pwm capabilities
  pwm: add push-pull mode support
  pwm: add documentation for pwm push-pull mode
  pwm: atmel: add push-pull mode support

 Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
 Documentation/pwm.txt                         |  42 ++++++++-
 drivers/pwm/core.c                            | 125 ++++++++++++++++++++++=
+++-
 drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-----=
--
 drivers/pwm/pwm-clps711x.c                    |  10 ++-
 drivers/pwm/pwm-cros-ec.c                     |   1 +
 drivers/pwm/pwm-pxa.c                         |   1 +
 drivers/pwm/sysfs.c                           |  61 +++++++++++++
 include/dt-bindings/pwm/pwm.h                 |   2 +
 include/linux/pwm.h                           |  64 +++++++++++++
 10 files changed, 395 insertions(+), 40 deletions(-)

--=20
2.7.4
